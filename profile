# is-interactive
export PATH="$PATH":"$HOME"/bin
[ "$APORTSDIR" ] && export APORTSDIR
if command -v fish >/dev/null 2>&1; then
    [ -t 0 ] && exec fish -l
fi
# vim: filetype=sh
