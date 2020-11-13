function fish_right_prompt
  set_color white
  printf "%s" (prompt_pwd)
  if git diff-files --quiet --ignore-submodules 2>/dev/null;
    set_color green
  else
    set_color red
  end

  printf "%s" (__fish_git_prompt)
  set_color white
end
