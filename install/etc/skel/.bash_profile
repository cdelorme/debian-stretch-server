#!/bin/bash
# if bashrc exists and the terminal has stdin load it
[ -f ~/.bashrc ] && test -t 0 && . ~/.bashrc
