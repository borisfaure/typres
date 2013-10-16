#!/usr/bin/env bash

set -e
#set -x

WL=0

r() {
    echo -ne '\033}qs\0' && read -s s
    COLUMNS=${s/;*}
    LINES=${s#*;}
    LINES=${LINES/;*}
    WL=0
}

t() {
    #TODO
    echo "$@"
}

function b {
    #TODO
    echo "$@"
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
    local str=$@
    local lines=()
    local len=$COLUMNS
    local line=""
    for w in $str; do
        local l=${#w}
        if [[ l -lt $len ]] ; then
            len=$(( $len - $l ))
            line="$line $w"
        else
            len=$COLUMNS
            lines+=("$line")
            line=""
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
}

f() {
    WL=$(( $WL + 1 ))

    while [[ $WL -lt $LINES ]]; do
        echo ""
        WL=$(( $WL + 1 ))
    done
    echo $@
}

function s01 {
    c "Terminology - Oct 2013 - Where are we?"

    f $@
}
function s02 {
    t "whoami"

    b "Boris Faure aka billiob"
    b "developer on Enlightement and the EFL for 4 years"

    f $@
}




slides=(s01 s02)

clear

S=0
while true; do
    r
    if [[ $S -ge ${#slides[@]} ]]; then
        S=0
    fi
    if [[ $S -lt 0 ]]; then
        S=$(( ${#slides[@]} - 1))
    fi

    eval ${slides[$S]} "$S/${#slides[@]}"
    read answer
    case $answer in
        q*) exit;;
        n*) S=$(( $S + 1));;
        p*) S=$(( $S - 1));;
        r*) ;;
        *) S=$answer;;
    esac

done

