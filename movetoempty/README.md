# Move to Empty
When called, `movetoempty.sh`
moves the currently focused view to the next empty tag.

## Examples
There are windows on the `1st, 2nd & 4th` tag.
We call `movetoempty.sh` on a window, it will be moved to the `3rd`.  
Now we call `movetoempty.sh` again on a different window,
it will be moved to the `5th` tag.

## Dependencies 
- [ristate](https://gitlab.com/snakedye/ristate)
- A posix shell (dash, bash, ksh)
  + sleep
  + kill 
- grep
- sort
- awk
- xrags
- printf
- bc
