#!/bin/sh

# The tag lariza is on at all times
larizatag="512"

# Get the tag the user is on
# To do this, we must spawn ristate and kill it after a short wile,
# otherwise it will keep running indefinitely 
# Then we format the tags into a formula to add al the tags together and get them into a workable format
tag=$(printf "0$(printf "+2^(%s-1)" $(ristate -t | grep -o "[0-9]*" & sleep 0.2 && killall ristate))\n" | bc)

# spawn lariza (on current tag)
# assign the view to the $larizatag once it spawns
init() {
    riverctl spawn lariza &
    wlrctl toplevel waitfor app_id:lariza && wlrctl toplevel focus app_id:lariza &&\
    riverctl set-view-tags $larizatag && exit
}

spawn() {
    # Check if lariza is already on the current view
    wlrctl toplevel focus app_id:lariza
    # If it is, exit. else continue
    [ $(lswt -t | cut -f2,5 | grep -c "lariza.*true") -gt 0 ] && exit
    # temporarily focus both the $larizatag and current $tag
    riverctl set-focused-tags $(($tag+larizatag))
    # focus lariza
    wlrctl toplevel focus app_id:lariza
    # set lariza's view to the current tag
    riverctl toggle-view-tags $tag
    # unfocus the $larizatag
    riverctl set-focused-tags $tag

    # This way, we can toggle the tags of a view that is on a different tag
    # without switching back and forth which would cause annoying flashes
}

quit() {
    # If the current window is not lariza, pass it on to river,
    # otherwise toggle the current $tag on the view so that the window is no longer visible on the current $tag
    [ $(lswt -t  | cut -f2,5 | grep -c "lariza.*true") -lt 1 ] &&\
	riverctl close ||\
	riverctl toggle-view-tags $tag
}

# If no window with app_id:lariza is found, run the init function
[ $(lswt -t | cut -f2 | grep -c "lariza") -lt 1 ] && init

# Run the appropriate function depending on the first argument
case $1 in
    spawn)spawn;;
    quit)quit;;
    # Init is always checked, so we do not need a case for init
esac
