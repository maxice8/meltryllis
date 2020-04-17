#
# Load our actual configuration on a Read-Write place.
#
PATH="$HOME"/bin:"$HOME"/.local/bin:"$PATH"
ENV="$HOME"/etc/dash/env

export ENV PATH

case "$(tty)" in
	# If we start on a tty, start an upstart session
	/dev/tty1)
		# We can't export MOZ_ENABLE_WAYLAND in .pam_environment
		# because we have another environment that uses GDM with Xorg X11
		export MOZ_ENABLE_WAYLAND=1
		exec startup --user ;;
esac
