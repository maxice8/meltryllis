#
# Load our actual configuration on a Read-Write place.
#
if ! pgrep -x ssh-agent -u $(id -u) >/dev/null; then
	# This sets SSH_AUTH_SOCK and SSH_AGENT_PID variables
	eval "$(ssh-agent -s)"
	export SSH_AUTH_SOCK SSH_AGENT_PID
	cat > "$XDG_RUNTIME_DIR/ssh-agent-env" <<- __EOF__
	export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
	export SSH_AGENT_PID=$SSH_AGENT_PID
	__EOF__
else
	if [ -s "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
		. $XDG_RUNTIME_DIR/ssh-agent-env
	fi
fi

# Since these refer to $XDG_RUNTIME_DIR which is not set in .pam_environment
# and thus can't be referenced. Do it here manually
XAUTHORITY=${XDG_RUNTIME_DIR}/Xauthority
BSPWM_SOCKET=${XDG_RUNTIME_DIR}/bspwm_socket
BSPWM_STATE=${XDG_RUNTIME_DIR}/bspwm-state.json

ENV="$HOME"/etc/dash/env

export ENV XAUTHORITY BSPWM_SOCKET BSPWM_STATE 
