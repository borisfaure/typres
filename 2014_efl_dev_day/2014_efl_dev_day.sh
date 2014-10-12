#!/usr/bin/env bash

set -e
#set -x

. ../lib/typres.sh

function s_intro {
    c "Terminology - Oct 2014 - Beyond the words?"

    i "c" "../lib/terminology.png"
}

function s_me {
    t "$ whoami"

    local bullets=("Boris Faure aka billiob" \
        "developer on Enlightement and the EFL for more than 5 years" \
        "working on Terminology for quite some time"
    )
    b "${bullets[@]}"
}

function s_about {
    t "What is Terminology (in case you're really new here)?"

    local bullets=("The best terminal emulator" \
        "written with the EFL"
    )
    b "${bullets[@]}"
}

function s_whwd0 {
    t "What have we done during the past year?"

    i "c" "many_things.gif"
}

function s_whwd1 {
    t "Releases!!"

    i "c" "success_kid.jpg"
}

function s_whwd2 {
    t "Terminology 0.4 (Dec 2013)"

    local bullets=("A man page!" \
       "Text reflow" \
       "Compress backlog" \
       "Fixes and new bugs" \
       "257 days" \
       "316 commits" \
       "18 authors"
    )
    b "${bullets[@]}"
}

function s_whwd3 {
    t "Terminology 0.5 (Mar 2014)"

    local bullets=("Color settings"\
       "Wallpaper settings" \
       "Fixes and new bugs" \
       "190 days" \
       "111 commits" \
       "15 authors"
    )
    b "${bullets[@]}"
}

function s_whwd4 {
    t "Terminology 0.6 (July 2014)"

    local bullets=("New themes!" \
       "Miniview" \
       "Fixes and new bugs" \
       "113 days" \
       "155 commits" \
       "16 authors"
    )
    b "${bullets[@]}"
}

function s_whwd5 {
    t "Terminology 0.7 (now!!!)"

    local bullets=("Internationalization aka conquer the world!" \
       "Configurable key bindings" \
       "Fixes and fresh new bugs" \
       "212 days" \
       "197 commits" \
       "17 authors" \
       "0 issue found by Coverity"
    )
    b "${bullets[@]}"
}

function s_distro0 {
    t "Great, but we haven't conquered the world yet"

    i "c" "conquer_the_world.gif"
}

function s_distro1 {
    t "State of Terminology in distros"

    local bullets=("Good players: Gentoo, Arch, Bodhi, OpenSUSE" \
        "Bad players (yet): Debian, Mint, Ubuntu, CentOS, Mageia, Fedora…" \
        "Please ask your distro maintainers to ship Terminology" \
        "We will continue improving Terminology"
        )
    b "${bullets[@]}"
}

function s_next0 {
    t "What's next?"

    local bullets=("Bug fixing"\
        "Fix scrollback compression" \
        "Make miniview an awesome scrollbar" \
        "Improvements on CPU usage when on battery" \
        "Searchable buffer" \
        "Zooming on images" \
    )
    b "${bullets[@]}"
}


function s_next1 {
    t "What's next?"

    local bullets=("Instant Replay" \
        "Splits in tabs" \
        "Have “usual” tabs" \
        "Bold/Italic support" \
        "Tmux integration" \
        "…" \
        "Some awesome ideas you might have"
    )
    b "${bullets[@]}"
}

function s_gravatar {
    tf "Crazy ideas like…"

    cf "Gravatar integration!"

}

function s_end {
    tf "Questions ?"

    i "c" "questions.gif"
}

function s_eat {
    tf "Let's go eat!!"

    i "c" "food.gif"
}


slides=( s_intro s_me s_about s_whwd0 s_whwd1 s_whwd2 s_whwd3 s_whwd4 s_whwd5 \
    s_distro0 s_distro1 s_next0 s_next1 s_gravatar s_end )


typres "${slides[@]}"
