# Strict cursor
Make sure that the window which the cursor is above is always the focused window.
This behavious is simmilar to river's removed `focus-follows-cursor strict` option,
hence the name.
This script is however even stricter than the old river option.
As such, this script breaks the ability to change the focused window using keybinds
and also unfocuses window popups and such things.
I hope to fix this some day with another script which moves the cursor to the centre of the
window whenever the focus changes
(see [mousetofocus](https://github.com/user18130814200115-2/swayscrips/tree/main/mousetofocus) for an exmaple of this concept using sway).

## Dependencies
- wlrctl
- lswt
- a posix shell (bash, dash, ksh, etc.)
  - cut
  - sleep
