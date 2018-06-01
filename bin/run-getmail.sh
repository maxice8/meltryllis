#!/bin/sh
set -e
cd ~/etc/getmail
for file in rc-* ; do
	/usr/bin/getmail --rcfile "$file" --getmail ~/etc/getmail "$@"
done
