set -x GPG_TTY (tty)

if not pgrep -x ssh-agent -u (id -u)
	eval (ssh-agent -c)
	set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
	set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end
