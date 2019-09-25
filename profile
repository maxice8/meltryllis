#
# Load our actual configuration on a Read-Write place.
#
# Start gpg-agent 
if ! pgrep -x gnome-keyring-daemon -u $(id -u) >/dev/null; then
	# This sets the GNOME_KEYRING_CONTORL and SSH_AUTH_SOCK variables
	eval "$(gnome-keyring-daemon --start --daemonize --components=secrets,ssh-agent)"
fi

# Since these refer to $XDG_RUNTIME_DIR which is not set in .pam_environment
# and thus can't be referenced. Do it here manually
XAUTHORITY=${XDG_RUNTIME_DIR}/Xauthority
BSPWM_SOCKET=${XDG_RUNTIME_DIR}/bspwm_socket
BSPWM_STATE=${XDG_RUNTIME_DIR}/bspwm-state.json

ENV="$HOME"/etc/dash/env

export ENV XAUTHORITY BSPWM_SOCKET BSPWM_STATE GNOME_KEYRING_CONTROL SSH_AUTH_SOCK
