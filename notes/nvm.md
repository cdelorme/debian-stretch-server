
# [nvm](https://github.com/creationix/nvm) and [nodejs](https://nodejs.org/en/)

Start by installing nvm; I use the override to append the loader to the `~/.bash_profile` so it is loaded even if the terminal is not interactive (useful for automation):

	PROFILE=~/.bash_profile bash < <(curl -Ls https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh 2>& /dev/null)

Next you can install the latest stable version of node using tags from the official repository and set it as the default with an alias:

	. ~/.nvm/nvm.sh
	nvm install stable
	nvm alias default stable

One thing worth noting is node has a shared global workspace and is subject to a global interpreter lock.  If you want to isolate node software, [docker](https://www.docker.com/) is a good choice, otherwise a local copy of nvm per workspace will achieve the same.

_Unfortunately that's all I have for you; I don't wrote node software._


# conclusion

I highly recommend nvm if you are writing node projects.  _However, I think node itself is a mess._

It gives companies incentive to employ front-end developers as service developers or "full stack" without necessarily addressing the knowledge gap.

The standard library for nodejs is lacking, and the result is an excessive dependency on third party packages creating a myriad of new problems (_not withstanding security risks_).

While touted as having the largest shared code repository in the world, ignoring that a majority of it is unmaintained and abandoned projects.

While ES6 as of nodejs 8 addresses a majority of the syntax troubles, it is still a very different event driven programming language without much correlation to other languages.  This makes it difficult to reason about the code in a traditional way.

Finally, if you have been paying attention, it's actually [not that great of a performer in the real world](https://www.toptal.com/back-end/server-side-io-performance-node-php-java-go).
