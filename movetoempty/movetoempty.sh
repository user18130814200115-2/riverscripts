#!/bin/sh

raw=$(ristate -vt & sleep 0.2 && kill $! )
empty=$(printf "%s" "$raw" | grep -o "[0-9]" | sort -n  | awk '{for(i=p+1; i<$1; i++) print i} {p=$1}' | xargs -i_ printf "2^(_-1)\n" | bc)
riverctl set-view-tags $empty
