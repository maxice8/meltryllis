# Defined in - @ line 1
function gp --wraps='git gp' --description 'alias gp git gp'
  git gp $argv;
end
