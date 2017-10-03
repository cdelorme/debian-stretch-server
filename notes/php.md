
# php

I consider `php` to be a gateway development language, which has its pros and cons.

Nearly every old school web server shared hosting provides it by default.  The wide spread support, alongside `mysql` database, makes it easy to get started developing with.  It becomes easy to find developers who have programmed `php`, _not counting the level of that programming skill._

The end result is somewhat of a mess and most seasoned developers begin to recognize limits of the language and crave something new will move onto other technologies (node, golang, even java).  The code left behind becomes neglected or owned by the next seat of inexperienced programmers.

This is my personal experience; every early job was php, everyone stopped coding raw php and moved onto frameworks, then I looked at jobs with mixed technologies and haven't looked back.  There are still loads of jobs to work on legacy php stacks, but it doesn't hold my interest.

While I recognize its value as a gateway for new developers, it is not a technology I would praise for any other reason.  _However I have not worked with it in 5 years and they are 2 versions forward from my last experience so take these opinions with a grain of salt._


## php-fpm

The fast process manager is what I last worked with back when php5 was the latest release.

You will need to install several packages, which may vary depending on the functionality you need from php:

	apt install php-dev php-fpm php-common composer php-mcrypt php-opcache php-mysqlnd php-pgsql php-intl php-gd php-curl php-xmlrpc php-pear php-imagick php-apc php-xsl

Last I was working with php, I was using [composer](https://getcomposer.org/) for package management.  The encryption is almost always needed.  The opcache package can dramatically boost performance.  The mysql or pgsql packages are only required if you are talking to that database.    _The rest are miscellaneous and depend on what you are doing._

While you can send traffic directly to php-fpm, my experience generally involved static files and proxied php using `nginx`:

	# PHP Handler
	location ~ \.php$ {
	    try_files $uri =404;
	    include fastcgi_params;
	    fastcgi_pass unix:/var/run/php-fpm.sock;
	    fastcgi_index index.php;
	    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	}

_The socket file may differ depending on the version installed._


## alternatives

Other solutions are available, including hhvm from facebook, and [php-pm](https://github.com/php-pm/php-pm), an open source project offering similar functionality to php-fpm.

_I have neither setup nor tested either, and have no intention to, however I would recommend experimenting if it might buy you better performance in a production environment._


# conclusion

If you are getting started in software development, or seeking employment, then `php` can be an excellent skill.

If you are an experienced developer, [you are probably already aware of how it stacks up to alternative tools](https://www.toptal.com/back-end/server-side-io-performance-node-php-java-go).
