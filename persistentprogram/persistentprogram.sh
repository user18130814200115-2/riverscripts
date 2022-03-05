#!/bin/sh


# The tag cgull is on at all times
cgulltag="512"

# Get the tag the user is on
# To do this, we must spawn ristate and kill it after a short wile,
# otherwise it will keep running indefinitely 
# Then we format the tags into a formula to add al the tags together and get them into a workable format
#tag=$(ristate -t & pid=$!; sleep 0.2 && kill $pid)
#tag=$(echo "$tag" | grep -o "[0-9]*")
#tag=$(printf "0$(printf "+2^(%s-1)" $tag)\n" | bc)
tag=$(cat /tmp/focuslariza)


# spawn cgull (on current tag)
# assign the view to the $cgulltag once it spawns
init() {
    #riverctl spawn "cgull" &
    wlrctl toplevel waitfor app_id:cgull && wlrctl toplevel focus app_id:cgull &&\
    riverctl set-view-tags $cgulltag
}

spawn() {
    # If no window with app_id:cgull is found, run the init function
    [ $(lswt -t | cut -f2 | grep -c "cgull") -lt 1 ] && riverctl spawn cgull && init

    # Check if cgull is already on the current view
    wlrctl toplevel focus app_id:cgull
    # If it is, exit. else continue
    [ $(lswt -t | cut -f2,5 | grep -c "cgull.*true") -gt 0 ] && exit
    # temporarily focus both the $cgulltag and current $tag
    riverctl set-focused-tags $(($tag+cgulltag))
    # focus cgull
    wlrctl toplevel focus app_id:cgull
    # set cgull's view to the current tag
    riverctl toggle-view-tags $tag
    # unfocus the $cgulltag
    riverctl set-focused-tags $tag

    # This way, we can toggle the tags of a view that is on a different tag
    # without switching back and forth which would cause annoying flashes
}

quit() {
    # If the current window is not cgull, pass it on to river,
    # otherwise toggle the current $tag on the view so that the window is no longer visible on the current $tag
    if [ $(lswt -t | grep -v "Download Manager" | grep -c "cgull.*true") -lt 1 ]; then
	riverctl close
    else
	riverctl toggle-view-tags $tag
    fi
}

move() {
    printf "$1\n" > /tmp/focuslariza
    riverctl toggle-view-tags $1
    riverctl toggle-view-tags $tag
}

focus() {
    printf "%s\n" $1 > /tmp/focuslariza
    riverctl set-focused-tags $1
}


# Run the appropriate function depending on the first argument
case $1 in
    spawn)spawn;;
    quit)quit;;
    move)move $2;;
    focus)focus $2;;
    init)init;;
esac

