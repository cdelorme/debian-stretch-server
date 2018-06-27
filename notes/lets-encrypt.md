
# [lets-encrypt](https://letsencrypt.org/)

This service provides free SSL certificates using what is called ACME verification.

_Not only is this an exceptional development tool, it should be required for any publicly hosted site._

As of ACME v2 they added support for wild card certificates.

These certificates are generally short-lived (eg. 90 days), and so automatic renewal is highly recommended.

_Your choice of certificate type, hosting, DNS management, and ACME client will effect how you automate._


## host

My hosting choice is digital ocean, and they also manage my DNS records.

I preemptively created matching TXT records with unusable values, specifically to speed up propagation.

I also created an API Key for the servers that would update those records.


## client

I used [dehyrdrated](https://github.com/lukas2511/dehydrated) to deal with SSL certificate renewal.

This is because it is light weight, has very few dependencies all of which are basic linux utilities, and it gives me control over complex behavior.

_This client is already installed with default configuration and ready to be initialized._


### automation

**When testing scripts set `CA="https://acme-staging-v02.api.letsencrypt.org/directory"` to avoid hitting rate limits before you are ready to use the final results.**

Assuming you are using `DNS-01` verification, you will want to register an API key and write commands in `/etc/dehydrated/hooks.sh` to create the record.  _This file must be executable and readable by the user dehydrated is configured to run as._

Start by initializing dehydrated:

	dehydrated --register --accept-terms -k /etc/dehydrated/hooks.sh

Populate `/srv/ssl/domains.txt` with a line per certificate issued; multiple domain names can exist per line.

Run the first-time creation:

	dehydrated -c -k /etc/dehydrated/hooks.sh

_I recommend creating symlinks to the files from each dependent system, as sometimes more than one may use the same certificate._  Otherwise you can add copy commands to `/etc/dehydrated/hooks.sh` and more service restarts as needed.

It prevents renewal unless there are under 30 days remaining, which means you can safely run it every 1st and 15th at 3AM in a cron job:

	0 3 1,15 * * /usr/local/bin/dehydrated -c -k /etc/dehydrated/hooks.sh
