#!/bin/sh

# The tag lariza is on at all times
larizatag="512"

# Get the tag the user is on
# This currently uses yambar (by outputting yambar's debug to a temporary file) which is not a very graceful solution.
# I might use ristate in the future
tag="$(grep "zriver_output_status_v1@3.focused_tags" /tmp/yambar | tail -n 1 | sed -E 's/.*\(([0-9]*)\)/\1/')"

# spawn lariza (on current tag) and assign the view to the $larizatag as well once it spawns
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
