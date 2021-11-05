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

## Note
The scrip can also be used as a oneliner:
`raw=$(ristate -vt & sleep 0.2 && kill $! ); riverctl set-view-tags $(printf "%s" "$raw" | grep -o "[0-9]" | sort -n  | awk '{for(i=p+1; i<$1; i++) print i} {p=$1}' | xargs -i_ printf "2^(_-1)\n" | bc)`
