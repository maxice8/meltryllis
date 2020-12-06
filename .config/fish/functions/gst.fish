# Defined in - @ line 1
function gst --wraps='git st' --description 'alias gst git st'
  git st $argv;
end
