
# ssl certificates

**It is now possible to get trusted ssl certificats for free, meaning that there is absolutely no reason why _any_ website should be using traditional http anymore.**

The movement leading the charge on this is [letsencrypt](https://letsencrypt.org/), and there are plenty of tools and services available in all manner of languages for all manner of servers.


## [automation](https://letsencrypt.org/docs/client-options/)

There are plenty of clients in various languages, and which even connect with common systems (eg. `nginx`, `haproxy`, and `apache2`) to automate the process of certificate recycling.


## [services](https://www.sslforfree.com/)

If you don't want to setup tools on your system, you can do it over the web for free.


## limitations

There are three major limitations currently:

- certificates are only valid for 90 days
- there is no wildcard support, _yet (coming in January 2018)_
- there is no warranty

The first two are mostly negligible given that you can automate the process of refreshing certificates, and the cost is free.

_The third is the main concern for most companies._  However, given the recent advent of CA authorities violating the trust agreement and being revoked from major browsers I would wager it's a gamble either way.
