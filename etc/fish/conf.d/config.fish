set -x GPG_TTY (tty)

if not set -q SSH_AGENT_PID
	eval (command ssh-agent -c | sed 's/^setenv/set -Ux/')
end
