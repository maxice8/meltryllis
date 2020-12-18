function fish_prompt
    if test "$SSH_CLIENT"
        set_color brwhite; echo -n "["
        set_color ff571a; echo -n "ssh"
        set_color brwhite; echo -n "::"
        set_color 00b3b3
        if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 2222
            echo -n "toolbox"
        else if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 22
            echo -n "host"
        else
            echo -n (echo -n $SSH_CLIENT | string split ' ' | tail -1)
        end
        set_color brwhite; echo -n "] "
    else if test -n "$TOOLBOX_PATH"
        set_color brwhite; echo -n "["
        set_color c53bff; echo -n "container"
        set_color brwhite; echo -n "::"
        set_color 00b3b3; echo -n "toolbox"
        set_color brwhite; echo -n "] "
    end
    set_color brwhite
    echo -n "───── "
    set_color brwhite
end
