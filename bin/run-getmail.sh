#!/bin/sh
set -e
cd ${XDG_CONFIG_HOME}/getmail
for file in rc-* ; do
	/usr/bin/getmail --rcfile "$file" --getmail ~/etc/getmail "$@"
done
