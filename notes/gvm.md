
# [gvm](https://github.com/moovweb/gvm) and [golang](https://golang.org/)

Start by installing gvm; unfortunately there is no easy flag to override the installation profile (once again, `~/.bash_profile` for me helps with automation or dependent software when a non-interactive shell is used, _such as sublime text with the GoSublime plugin_):

	GVM_NO_UPDATE_PROFILE=1 bash < <(curl -Ls https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer 2>& /dev/null)
	grep "gvm" ~/.bash_profile &> /dev/null || echo ". ~/.gvm/scripts/gvm" >> ~/.bash_profile

Once installed you can load it and perform a binary install of the latest version of go by its release tag:

	. ~/.gvm/scripts/gvm
	gvm install go1.9 -B
	gvm use go1.9 --default

_While semantically correct, golang does not use moving tags such as `stable` so you have to actually pay attention to the available releases._


# conclusion

Having played with the language now for more than a few years, my opinion is that it is the best option out there for general purpose development _as long as you don't need a local graphical interface._

The reasons are numerous, between the performance, fabulous standard library, built-in functionality such as detailed profiling, and far and away the best tooling I have ever encountered for any language.  Pair that with nearly painless cross compilation (unless using external dependencies) and automatically enforced formatting to eliminate dumb arguments, and you have a hell of a productive workspace.
