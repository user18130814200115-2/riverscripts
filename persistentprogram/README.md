# Persistent program
This scipt allows for the existence of a persitent program (one which never closes)
that lives on a seperate tag (512 by default).

I use this for my webbrowser
[lariza](https://github.com/user18130814200115-2/userslariza)


wich does not handle seperate instances very well.
Therfore, whenever I call lariza (through a .desktop file),
it executes `persistentprogram.sh spawn`. 
Which calls the prgram to the current tag,
this also virtually eliminates startup time.

Though lariza is hardcoded,the source code is easily modifyable,
a simple `s/lariza/inser program/g` should do the trick.

## Dependencies
- lswt
- wlrctl
- yambar (to be replaced with ristate in the future)
- grep
- a posix shell (dash, bash, kash, etc.)

## Usage
With `persistentprogram.sh` in your PATH:

1. make a .desktop file for ypur programm with the `Exec` line calling `persistentprogram.sh spawm`.
2. Map your usual `quit` keybind to `spawn persistentprogram.sh quit`.
  - This comma d willpass on usual quit requests to river, but not for the persistent program.
3. I like to load the persietent program on startup my calling `persistentprogram.sh` in my river init.
