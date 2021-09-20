# Persistent program
This script allows for the existence of a persistent program (one which never closes)
that lives on a separate tag (512 by default).

I use this for my web browser
[lariza](https://github.com/user18130814200115-2/userslariza)
which does not handle separate instances very well.
Therefore, whenever I call lariza (through a .desktop file),
it executes `persistentprogram.sh spawn`. 
Which calls the program to the current tag,
this also virtually eliminates startup time.

Though lariza is hardcoded, the source code is easily modifiable,
a simple `s/lariza/insert program/g` should do the trick and allow for using the script with any program.

## Dependencies
- [lswt](https://git.sr.ht/~leon_plickat/lswt)
- [wlrctl](https://git.sr.ht/~brocellous/wlrctl)
- [yambar](https://codeberg.org/dnkl/yambar) (to be replaced with [ristate](https://github.com/snakedye/ristate) in the future)
- a posix shell (dash, bash, ksh, etc.)
   + grep
   + cut
   + tail
   + sed (GNU)

## Usage
With `persistentprogram.sh` in your PATH:

1. Run yambar like so `riverctl spawn "WAYLAND_DEBUG=1 yambar 2> /tmp/yambar"`
    - This is to get the current tag. I fully intend to replace this with `ristate` in the future
2. make a .desktop file for your program with the `Exec` line calling `persistentprogram.sh spawm`.
3. Map your usual `quit` key bind to `spawn persistentprogram.sh quit`.
    - This command will pass on usual quit requests to river, but not for the persistent program.
4. I like to load the persistent program on startup, by calling `persistentprogram.sh` with no arguments in my river init.
