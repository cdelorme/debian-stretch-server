
# [debian stretch server](https://github.com/cdelorme/debian-stretch-server)

These days I tend to provision light weight servers in AWS and DigitalOcean.

**I don't use ["configuration management software"](notes/configuration-management-software.md).**

To help alleviate testing of images I use [`packer`](https://www.packer.io/) to [build a base image](build.json) using [`virtualbox`](https://www.virtualbox.org/wiki/Downloads).  _In the future I may also add builders for aws and digital ocean._  Currently the only required variable is `-var "root_password="`, which is used by the preseed of debian from an iso.

If you are provisioning a machine using a debian stretch image you can also use my [automation script](stretch.sh) as "user-data", or run it with `sudo` on an already provisioned machine.


## expectations

My expectations for a server are a healthy supply of tools, an enhanced prompt, and generally [`nginx`](install/etc/nginx/) as a proxy service.

Note that some packages may already exist on the machine, but are included to be certain.  _For example, `ca-certificates` exists on a base debian iso install with only "standard utilities", but not on the latest aws base debian image; inversely `resolvconf` exists on the aws base debian image, but not as part of the "standard utilities" of bare debian iso install._

I lock everything down with [`iptables`](install/etc/iptables/iptables.rules), but leave a commented rule for standard web traffic to be easily enabled.  A non-root user should be configured with sudo privileges (but not passwordless).  The root account should be unable to login via ssh.  Multiple failed login attempts should block for 15 minutes.

I choose not to install any interpreters or build tools.  The primary reason is that the purpose of a machine will vary and there are a lot of tools that may not be needed.  The secondary reasons are possibly bad practice compiling on your production server, disk space consumption by all the additional tools, and potential security gaps when adding extra software needlessly.

I have documented the installation process for many additional tools, _although some may be outdated_:

- [`msmtp-mta` (_an alternative to `exim4`_)](notes/msmtp-mta.md)
- [go with `gvm`](notes/gvm.md)
- [node with `nvm`](notes/nvm.md)
- [php-fpm](notes/php.md)

I won't cover installation of databases (eg. mysql, postgresql, mongodb, etc...) or docker.  That's an exercise I leave to the reader.

_Also if you are running raw hardware, you may want to invest some effort into `lm-sensors` and `watchdog` packages to deal with hardware failure._

For further documentation, refer to my [notes](notes/).
