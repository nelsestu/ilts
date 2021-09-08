#!/bin/bash

# https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
# some script friendly logging utility functions, depends on
# go get github.com/wwalker/ilts (for in line time stamps)

alias iso8601="date +%Y-%m-%dT%H:%M:%S"

function justlog(){
  name=$(basename "$1")
  log=~/logs/${name}-$(iso8601)
  "$@" > "$log" 2>&1
}

function timelog(){
  name=$(basename "$1")
  log=~/logs/${name}-$(iso8601)
  # https://github.com/wwalker/ilts
  # You could replace ilts with ts
  # /usr/bin/ts %FT%H:%M:%.S
  "$@" |& ilts -S -E > "$log" 2>&1
}

function newestlog(){
  name=$(basename "$1")
  ls  ~/logs/"${name}"* | tail -1
}

function viewlog(){
  name=$(basename "$1")
  view $( newestlog "$name" )
}

function lesslog(){
  name=$(basename "$1")
  less $( newestlog "$name" )
}
