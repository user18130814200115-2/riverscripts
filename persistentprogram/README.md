# Persistent program
This script allows for the existence of a persistent program (one which never closes)
that lives on a separate tag (512 by default).

I use this for my web browser
[cgull](https://github.com/user18130814200115-2/userslariza)
which does not handle separate instances very well.
Therefore, whenever I call cgull (through a .desktop file),
it executes `persistentprogram.sh spawn`. 
Which calls the program to the current tag,
this also virtually eliminates startup time.

Though lariza is hardcoded, the source code is easily modifiable,
a simple `s/cgull/insert program/g` should do the trick and allow for using the script with any program.

## Dependencies
- [lswt](https://git.sr.ht/~leon_plickat/lswt)
- [wlrctl](https://git.sr.ht/~brocellous/wlrctl)
- a posix shell (dash, bash, ksh, etc.)
   + grep
   + cut
   + bc
   + printf

## Usage
With `persistentprogram.sh` in your PATH:

1. make a .desktop file for your program with the `Exec` line calling `persistentprogram.sh spawm`.
2. Map your usual `quit` key bind to `spawn persistentprogram.sh quit`.
3. Map your usual `move` key bind to `spawn persistentprogram.sh move`.
4. Map your usual `focus` key bind to `spawn persistentprogram.sh focus`.
5. I like to load the persistent program on startup, by calling `persistentprogram.sh` with no arguments in my river init.

You can use the following example for your config:
```
#!/bin/zsh
for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))

    # Mod+[1-9] to focus tag [0-8]
    riverctl map normal $mod $i spawn "focuslariza focus $i"

    # Mod+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal $mod+Shift $i spawn "focuslariza move $tags"
done

# Quit the current view
riverctl map normal $mod+Shift Q spawn "focuslariza quit"

```
