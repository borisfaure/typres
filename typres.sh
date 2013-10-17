#!/usr/bin/env bash

set -e
#set -x

r() {
    echo -ne '\033}qs\0' && read -s s
    COLUMNS=${s/;*}
    LINES=${s#*;}
    LINES=${LINES/;*}
    WL=1
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
            line=""
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
    echo $@
    echo -ne '\033[0m'
}

function s01 {
    c "Terminology - Oct 2013 - Where are we?"

    #local h=$(( $LINES - $WL - 1 ))
    #tycat -c -g ${COLUMNS}x9 terminology.png
    #WL=$(( $WL + 9 ))
}
function s_end {
    c "Questions ?"

    #local h=$(( $LINES - $WL - 1 ))
    #tycat -c -g ${COLUMNS}x9 terminology.png
    #WL=$(( $WL + 9 ))
}
function s02 {
    t "$ whoami"

    local bullets=("Boris Faure aka billiob" \
    "developer on Enlightement and the EFL for 4 years" \
    "working on terminology for more than a year")
    b "${bullets[@]}"
}




slides=(s01 s02 s_end)

clear




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

