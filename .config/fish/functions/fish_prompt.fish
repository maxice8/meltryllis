function fish_prompt
    set_color green
    if test "$SSH_CLIENT"
        if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 2222
            echo -n "[ssh::toolbox] "
        else if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 22
            echo -n "[ssh::host] "
        else
            echo -n "[ssh::"(echo -n $SSH_CLIENT | string split ' ' | tail -1)"] "
        end
    else
        test -n "$TOOLBOX_PATH" && echo -n "[container::toolbox] "
    end
    set_color white
    echo -n "───── "
    set_color white
end
