set -x GPG_TTY (tty)

if not set -q SSH_AGENT_PID
	eval (ssh-agent -c)
end
