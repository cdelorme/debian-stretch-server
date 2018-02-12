#!/bin/bash -e

# fail if not running with root permissions
[ $(id -u) -ne 0 ] && echo "must be executed with root permissions..." 1>&2 && exit 1

# ask for required input
[ "$(id $EUID)" != "root" ] && [ -z "$username" ] && username=$(id $EUID -un)
while [[ -z "$username" && "$username" != "root" ]]; do read -p "please enter a non-root username to configure: " username; done
while ! id $username &> /dev/null && [ -z "$password" ]; do read -p "please enter a password for $username: " -s password; echo ""; done

# ask for optional input
[ -z "$github_username" ] && read -p "please enter a github username to synchronize authorized keys: " github_username

# show the user everything that transpires henceforth
set -x

# update packages and install base utilities
export DEBIAN_FRONTEND=noninteractive
apt clean
apt update
apt upgrade -y
while ! apt install -y ssh sudo vim ntp tmux git unzip curl wget rsync jq bash-completion command-not-found ca-certificates resolvconf nginx-full; do sleep 1; done

# install source files and update then restart effected services
[ -d /tmp/debian-stretch-server/install ] || git clone https://github.com/cdelorme/debian-stretch-server /tmp/debian-stretch-server
rsync -Pav /tmp/debian-stretch-server/install/ /
rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
/etc/network/if-up.d/iptables
systemctl restart nginx

# secure ssh by disabling root access and only accepting ssh keys going forward
sed -i "/^#\?PermitRootLogin.*[yn].*/d" /etc/ssh/sshd_config
sed -i "/^#\?PasswordAuthentication.*[yn].*/d" /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
systemctl restart sshd

# update command not found archive
update-command-not-found

# set vim.basic as the default editor
update-alternatives --set editor /usr/bin/vim.basic

# add pam tally locking
[ $(grep -c "pam_tally2" /etc/pam.d/common-auth) -eq 0 ] && echo "auth required pam_tally2.so deny=4 even_deny_root onerr=fail unlock_time=600 root_unlock_time=60" >> /etc/pam.d/common-auth
[ $(grep -c "pam_tally2" /etc/pam.d/common-account) -eq 0 ] && echo "account required pam_tally2.so" >> /etc/pam.d/common-account

# fix default permissions (secure by group)
sed -i 's/UMASK\s*022/UMASK\t\t002/' /etc/login.defs
[ $(grep -c "umask=002" /etc/pam.d/common-session) -eq 0 ] && echo "session optional pam_umask.so umask=002" >> /etc/pam.d/common-session

# disable capslock forever in favor of another ctrl and reload console configuration
if [[ -f /etc/default/keyboard && $(grep "XKBOPTIONS" /etc/default/keyboard | grep -c "ctrl:nocaps") -eq 0 ]]; then
	sed -i 's/XKBOPTIONS.*/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
	dpkg-reconfigure -phigh console-setup
fi

# create and configure username
if ! id $username &>/dev/null; then
	useradd -m -s /bin/bash $username
	echo "${username}:${password}" | chpasswd -c SHA512
	usermod -aG sudo,users,disk,adm,netdev,plugdev,www-data $username
else
	[ $EUID -ne 0 ] && rsync -Pav /etc/skel/ $(getent passwd $username | cut -d: -f6)/
fi

# install dot-files for root
rsync -Pav /etc/skel/ $(getent passwd root | cut -d: -f6)/

# add crontab to update keys, update keys, and set git username
[ -n "$github_username" ] && su $username -c "(crontab -l 2> /dev/null | grep -v 'update-keys'; echo '@hourly /usr/local/bin/update-keys $github_username') | crontab -"
[ -n "$github_username" ] && su $username -c "/usr/local/bin/update-keys $github_username"

# setup /srv/www and /srv/git /w stickybit for group on the parent folders
mkdir -p /srv/{www,git}
chown ${username}:www-data /srv/{www,git}
chmod 2750 /srv/{www,git}
