#!/bin/bash

# add local bin to path
export PATH=/usr/local/bin:$PATH

# if bashrc exists and the terminal has stdin load it
[ -f ~/.bashrc ] && test -t 0 && . ~/.bashrc
