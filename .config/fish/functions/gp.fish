# Defined in - @ line 1
function gp --wraps='git p' --description 'alias gp git p'
  git p $argv;
end
