#!/bin/bash
set -euo pipefail

function get_prev_version() {
	prev_tag=$(git describe --tags `git rev-list --tags --max-count=1` )
	prev_month=$(echo $prev_tag | grep -o -E '\.[0-9]+\.' | sed 's/\.//g')
	build_number=$(echo $prev_tag | grep -o -E '[0-9]+$')
}

function compare_month() {
	if [ $(date +"%m") != $prev_month ]; then
	   build_number=1
	else
	   (( build_number=build_number +1 ))
	fi
}

function set_next_version() {
	release_tag=$(date +"%y.%m".$build_number)
	echo "Next version: $release_tag"
}

get_prev_version
compare_month
set_next_version