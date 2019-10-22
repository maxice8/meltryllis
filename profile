#
# Load our actual configuration on a Read-Write place.
#
# This should be started automatically via PAM
# Start gnome-keyring
if ! pgrep -f gnome-keyring-daemon -u $(id -u) >/dev/null; then
	# This sets the GNOME_KEYRING_CONTORL and SSH_AUTH_SOCK variables
	eval "$(gnome-keyring-daemon --replace --daemonize --components=secrets,ssh)"
	export GNOME_KEYRING_CONTROL SSH_AUTH_SOCK
	cat > "$XDG_RUNTIME_DIR/gnome-keyring-env" <<- __EOF__
	export GNOME_KEYRING_CONTROL=$GNOME_KEYRING_CONTROL
	export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
	__EOF__
else
	if [ -s "$XDG_RUNTIME_DIR/gnome-keyring-env" ]; then
		. $XDG_RUNTIME_DIR/gnome-keyring-env
	fi
fi

# Since these refer to $XDG_RUNTIME_DIR which is not set in .pam_environment
# and thus can't be referenced. Do it here manually
XAUTHORITY=${XDG_RUNTIME_DIR}/Xauthority
BSPWM_SOCKET=${XDG_RUNTIME_DIR}/bspwm_socket
BSPWM_STATE=${XDG_RUNTIME_DIR}/bspwm-state.json

ENV="$HOME"/etc/dash/env

export ENV XAUTHORITY BSPWM_SOCKET BSPWM_STATE 
