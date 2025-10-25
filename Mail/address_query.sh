#!/bin/bash
# Provides results for neomutt's query_command opotion

set -e
set -u

function query_notmuch() {
    out=$(notmuch address from:"*$1*")
    out=$(echo "$out" | sed -E 's/^(.*) <([^>]+)>/\1\t"\2"\t/')
    out=$(echo "$out" | sed -E 's/^([^\t]*)\t([^\t]*)\t(.*)$/\1\t\2\t\3 notmuch/')
    echo "$out"
}

function query_khard() {
    out=$(khard email --parsable --remove-first-line "$1" 2> /dev/null)
    out=$(echo "$out" | sed -E 's/^([^\t]*)\t([^\t]*)\t(.*)$/\1\t\2\t\3 khard/')
    echo "$out"
}

out+=$(query_notmuch "$@")
if [[ -n $out ]]; then
    out+=$'\n'
fi
out+=$(query_khard "$@")

echo "$out"
