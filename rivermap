#!/bin/sh

#MIT License
#
#Copyright (c) 2021 user18130814200115-2
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

format() {
    # PRELIMINARY DOCUMENT SETUP
    echo ".TITLE \"River Mappings\"\n.AUTHOR \"$USER\"\n.PRINTSTYLE TYPESET\n.START"
    
    # GET THE BOTH THE MAP AND LOOP LINES FROM THE INIT FILE.
    # WE FORMAT THEM INTO SHELL CODE AND PASS IT INTO SH TO GET A LIST OF ALL THE MAPINGS EVEN THOSE INSIDE LOOPS
    # RELOCATE THE -release TAGS TOT THE END ALSO SEPERATE THE MODIFIER AND KEYSIM WITH A "+", THIS COMBINATION WILL HENCEFORTH BE REFFERED TO AS A "KEYCOMBO"
    raw=$(grep " map \\|for\\|done\\|do\\|[a-Z]*=" .config/river/init | grep "^[^#]" | sed 's/riverctl map/echo/' | sh | sed -E 's/(-release )?([^ ]*) ([^ ]*) ([^ ]*) (.*)/\2 \3+\4\1 \5/')
    
    # GET A LIST OF ALL THE MODES TO LOOP OVER
    modes=$(echo "$raw" | cut -d" " -f1 | sort | uniq)
    echo "$modes" | while read line; do
    # WE MAKE A NEW PAGE WITH A HEADING TO OUTPUT THE MAPPINGS OF EACH MODE
        echo ".NEWPAGE\n.HEADING 2 \"$line\""
    # GREP THE MAPPINGS FOR THE MODE WE ARE CURRENTLY WORKING ON
    # INSERT A NEWPAGE AFTER EVERY 38 MAPPINGS. IF WE DO NOT DO THIS, THE FINAL MAPPING ON EACH PAGE WILL HAVE THE KEYCOMBO ON ONE PAGE AND THE COMMAND ON ANOTHER
    # FORMAT THE LINE SO THAT THE KEYCOMBO IS FLUSHED LEFT AND THE COMMAND FLUSHED RIGHT ON THE SAME LINE SPACED CORRECTLY
    # REMOVE THE "NONE" PARTS OF THE KEYCOMBO
        echo "$raw" | grep "^$line " | sed '0~38 s/$/\n.NEWPAGE/g' | sed -E 's/[^ ]* ([^ ]*) (.*)/.LEFT\n\1\n.SPACE -1\n.TI \\w"\1 "\n.QUAD R\n\2/' | sed 's/None+//'
    done
}

# COMPILE THE FORMATTED DOCUMENT AND PIPE IT INTO ZATHURA
format | groff -mom -Tpdf | zathura -

# ALTERNATIVELY, IF YOU DO NOT USE ZATHURA, YOU CAN UNCOMMENT THE LINES BELOW TO FORMAT INTO A TEMPORARY FILE.
#format | groff -mom -Tpdf > /tmp/rivermap

# THEN ADD A LINE TO OPEN THE PDF WITH YOUR PREFERED PDF VIEWER, FOR INSTANCE:
# mupdf /tmp/rivermap
