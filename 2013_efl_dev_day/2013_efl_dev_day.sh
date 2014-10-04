#!/usr/bin/env bash

set -e
#set -x

. ../lib/typres.sh

function s_intro {
    c "Terminology - Oct 2013 - Where are we?"

    i "c" "../lib/terminology.png"
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
    "11 Tasks as wishlist")
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
function s_release {
    c "Next release at the end of the year, after efl 1.8"

    i "c" "terminology.png"
}
function s_troll {
    t "Terminology is an OS, like emacs, except better"
    local bullets=( "Elementary is not for you?" \
       "Write your apps for Terminology!"
       "Most languages supported!")
    b "${bullets[@]}"
}
function s_end {
    t "Questions ?"
    i "c" "grumpy.gif"
}


slides=(s_intro s_me s_about s_interlude0 s_features1 s_interlude1 \
s_features2 s_interlude2 s_features3 s_figures s_help s_can_do_it s_release \
s_troll s_end)


typres "${slides[@]}"
