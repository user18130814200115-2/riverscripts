# rivermap
List keybinds for the river wayland compositor.
This script prases your river init file. However currently, it only works with shell written init files like the base config.

## Dependencies
- [river](https://github.com/ifreund/river)
- Any Posix compient Shell (dash, bash, zsh, ksh)
- grep
- GNU sed
- cut
- sort
- uniq
- groff
- zathura*

\* Zathura is optional but default. Edit the final lines of `rivermap` for other document viewers:
```
# ALTERNATIVELY, IF YOU DO NOT USE ZATHURA, YOU CAN UNCOMMENT THE LINES BELOW TO FORMAT INTO A TEMPORARY FILE.
#format | groff -mom -Tpdf > /tmp/rivermap

# THEN ADD A LINE TO OPEN THE PDF WITH YOUR PREFERED PDF VIEWER, FOR INSTANCE:
# mupdf /tmp/rivermap
```
## Usage
By default, you can just run `rivermap.sh` to compile and open a pdf with all your mappings.
`rivermap.sh` can of course be given a keybinding in your river init.
