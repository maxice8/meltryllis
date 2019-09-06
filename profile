#
# Load our actual configuration on a Read-Write place.
#
# Start gpg-agent 
if ! pgrep -x ssh-agent -u $(id -u) >/dev/null; then
	eval ssh-agent
fi

ENV="$HOME"/etc/dash/env

export ENV
