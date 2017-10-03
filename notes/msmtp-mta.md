
# `msmtp-mta`

I generally despise mail servers; they are never easy to configure and often have limited application such as administrative notifications.  Worse is that debian by default still installs `exim4`, _one of the most complex mail transport agents._

However if you need a mail transport agent for smtp relay, but want something lightweight with human readable configuration, then the `msmtp-mta` package is likely your best option.

An example of its configuration (`/etc/msmtprc`):

	# Set default values for all following accounts.
	defaults
	tls on
	tls_trust_file /etc/ssl/certs/ca-certificates.crt

	# Default Account
	account gmail
	host smtp.gmail.com
	port 587
	auth on
	user username
	password password
	from username@gmail.com

	# Set a default account
	account default : gmail

Be sure to lock read permissions since it contains a raw password (eg. `chmod 0600 /etc/msmtprc`).

The `-mta` package should automatically create a symbolic link to `sendmail` and purge `exim4` leaving you with a cleaner system.

**_While it offers support for multiple sender accounts, if you want to send trusted email to non-administrators that won't end up in a filter then you may want to consider a registering a full email service provider._**


# references

- [msmtp configuration](http://www.serverwatch.com/tutorials/article.php/3923871/Using-msmtp-as-a-Lightweight-SMTP-Client.htm)
