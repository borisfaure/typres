#!/usr/bin/env bash

set -e
#set -x

r() {
    echo -ne '\033}qs\0' && read -s s
    COLUMNS=${s/;*}
    LINES=${s#*;}
    LINES=${LINES/;*}
    WL=0
}

PWD=`pwd`

t() {
    echo -ne '\033[0;97m'
    local str=$@
    local len=$COLUMNS
    local line=""
    local lines=()
    for w in $str; do
        local l=${#w}
        if [[ l -lt $len ]] ; then
            len=$(( $len - $l - 1 ))
            line="$line $w"
        else
            len=$COLUMNS
            lines+=("$line")
            line="$w"
        fi
    done;
    if [[ -n $line ]]; then
        lines+=("$line")
    fi
    for l in "${lines[@]}"; do
        WL=$(( $WL + 1 ))
        echo "$l"
    done
    echo -ne '\033[0m'
}

function b {
    local bullets=( "$@" )

    local L=0
    for str in "${bullets[@]}"; do
       local len=$(( $COLUMNS - 2 ))
       local line=""
       for w in $str; do
           local l=${#w}
           if [[ l -lt $len ]] ; then
               len=$(( $len - $l - 1 ))
               line="$line $w"
           else
               len=$(( $COLUMNS - 2 ))
               L=$(( $L + 1))
               line=""
           fi
       done
       if [[ -n $line ]]; then
           L=$(( $L + 1))
       fi
    done

    local l=$(( ($LINES - $WL - $L) / 2 ))
    for I in $(seq 1 $l); do
        echo ""
        WL=$(( $WL + 1 ))
    done

    local L=0
    for str in "${bullets[@]}"; do
       echo -ne '\033}it#2;1;'$PWD'/item_00.png\0'
       echo -ne '\033}ib\0##\033}ie\0'
       local len=$(( $COLUMNS - 2 ))
       local line=""
       for w in $str; do
           local l=${#w}
           if [[ l -lt $len ]] ; then
               len=$(( $len - $l - 1))
               line="$line $w"
           else
               len=$(( $COLUMNS - 2 ))
               echo "$line"
               WL=$(( $WL + 1 ))
               line="   $w"
           fi
       done
       if [[ -n $line ]]; then
           echo "$line"
           WL=$(( $WL + 1 ))
       fi
    done
}

i() {
    local h=$(( $LINES - $WL - 1 ))
    #tycat -c -g ${COLUMNS}x${h} you_can_do_it.gif
    echo -ne '\033}i'$1'#'$COLUMNS';'$h';'$PWD'/'$2'\0'
    for I in $(seq 1 $h); do
       echo -ne '\033}ib\0'
       for J in $(seq 1 $COLUMNS); do
          echo -ne '#'
       done
       echo -ne '\033}ie\0'
    done
    WL=$(( $WL + $h ))
}


vc() {
    local str=$@
    local spaces=$(( ($COLUMNS - ${#str}) / 2 ))
    for I in $(seq 1 $spaces); do
        echo -n " "
    done
    echo $str
    WL=$(( $WL + 1 ))
}

c() {
    echo -ne '\033[0;97m'
    local str=$@
    local lines=()
    local len=$COLUMNS
    local line=""
    for w in $str; do
        local l=${#w}
        if [[ l -lt $len ]] ; then
            len=$(( $len - $l - 1 ))
            line="$line $w"
        else
            len=$COLUMNS
            lines+=("$line")
            line="$w"
        fi
    done;
    if [[ -n $line ]]; then
        lines+=("$line")
    fi

    local l=$(( ($LINES - ${#lines[@]}) / 2 ))
    for I in $(seq 1 $l); do
        echo ""
        WL=$(( $WL + 1 ))
    done


    for l in "${lines[@]}"; do
        vc $l
    done
    echo -ne '\033[0m'
}

f() {
    WL=$(( $WL + 1 ))

    while [[ $WL -lt $LINES ]]; do
        echo ""
        WL=$(( $WL + 1 ))
    done
    echo -ne '\033[104;90m'
    echo -n $@
    echo -ne '\033[0m '
}

function s_intro {
    c "Terminology - Oct 2013 - Where are we?"

    i "c" "terminology.png"
}
function s_me {
    t "$ whoami"

    local bullets=("Boris Faure aka billiob" \
    "developer on Enlightement and the EFL for 4 years" \
    "working on Terminology for more than a year")
    b "${bullets[@]}"
}
function s_about {
t "What is Terminology (in case you're really new here)?"

    local bullets=("A terminal emulator" \
       "written with the EFL (hence this talk!)" \
       "with an impressive list of features")
    b "${bullets[@]}"
}
function s_interlude0 {
    t "Beware, the list is long"
    i "s" "long_list.gif"
}
function s_features1 {
    t "Features…"

    local bullets=("Most escape sequences supported" \
       "256 colors mode" \
       "Unicode and Wide-Characters support" \
       "All kinds of backgrounds (bitmaps, scalable, gifs, videos, pdf…)" \
       "Transparency" \
       "Bitmaps and scalable fonts" \
       "Themes: much more than just changing colors!"
    )
    b "${bullets[@]}"
}
function s_interlude1 {
    t "Interlude 1"
    i "s" "interlude1.gif"
}
function s_features2 {
    t "More Features…"

    local bullets=("URL, file path, email address detections" \
       "Inline display of content (images, videos…)" \
       "Multiple copy/paste selections and buffer support" \
       "Block text selection" \
       "Works on X, Wayland, linux framebuffer…" \
       "Can use OpenGl or OpenGL-ES2" \
       "Can be finger/touch controlled"\
    )
    b "${bullets[@]}"
}
function s_interlude2 {
    t "Interlude 2"
    i "s" "interlude2.gif"
}
function s_features3 {
    t "More and More Features…"

    local bullets=( "Single process and multiple windows/terminals" \
       "Splitting into multiple panes"\
       "Tabs with live thumbnail content" \
       "Custom escape sequences" \
       "Fast!" \
       "And more to come…" \
    )
    b "${bullets[@]}"
}
function s_figures {
    t "Figures"
    local bullets=( "Currently on version 0.3" \
    "a bit less than 20k LOC" \
    "737 commits to date" \
    "about 35 contributors" \
    "23 defects on Coverity" \
    "26 Bugs on Phab" \
    "11 Tasks as whishlist")
    b "${bullets[@]}"
}

function s_help {
    t "TODO"
    local bullets=( "Fix any remaining bugs" \
       "(yes, I know about selection and links)" \
    "Scrollbar (patch to review)" \
    "Bold/Italic support" \
    "Text search"
    "Settings UI (Keys, Colors…)" \
    "…" \
    "Patches are welcome!")
    b "${bullets[@]}"
}
function s_can_do_it {
    t "You can do it!"
    i "s" "you_can_do_it.gif"
}
function s_troll {
    t "Apps!"
    local bullets=( "Elementary is not for you?" \
       "Write your apps for Terminology!"
       "Most languages supported!")
    b "${bullets[@]}"
}
function s_end {
    t "Questions ?"
    i "c" "grumpy.gif"
}


slides=(s_intro s_me s_about s_interlude0 s_features1 s_interlude1 s_features2 s_interlude2 s_features3 s_figures s_help s_can_do_it s_troll s_end)



S=0
while true; do
    clear
    r
    if [[ $S -ge ${#slides[@]} ]]; then
        S=0
    fi
    if [[ $S -lt 0 ]]; then
        S=$(( ${#slides[@]} - 1))
    fi

    eval ${slides[$S]}

    f "$(($S+1))/${#slides[@]}"
    read answer
    case $answer in
        q*) exit;;
        n*) S=$(( $S + 1));;
        p*) S=$(( $S - 1));;
        r*) ;;
        *) S=$(( $answer - 1));;
    esac

done

