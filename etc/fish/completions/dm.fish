# Define our sockets
set -l sockets (/bin/ls $XDG_RUNTIME_DIR/dtach/)

complete -f -e -c dm
# All dm commands
complete -f -c dm -n "not __fish_seen_subcommand_from $sockets" -a "$sockets"
