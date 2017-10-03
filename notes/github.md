
# [github](https://github.com/)

I personally find github to be an amazingly useful service.

I leverage their profile public keys to automatically update `~/.ssh/authorized_keys` on my machines.

I also like having the ability to share public copies of all of my work and documentation someplace.  _It is very likely the reason you are seeing this document right now._

There are also some really cool, but relatively recent, features available if you use github for private repositories.


## [deploy keys](https://github.com/blog/2024-read-only-deploy-keys)

The addition of deploy keys allows you to grant read-only permissions on singular repositories to a public key, such as one on a server.

**This feature allows you to access private repositories in a secure way, without granting complete write access or sharing your basic authentication credentials with the server.**


## automatic updates

The real reason this can be amazing is that if you want to quickly test changes you could have a crontab check for and pull changes down from a private repository.

This is a valid model especially for distributed systems.


### automatic compilation

The dark side to this is that if your code involves compilation and the server is not just a build server, then you are basically adding compilation tools to the production system, which is generally a bad practice.
