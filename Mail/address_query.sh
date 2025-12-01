#!/bin/bash
# Provides results for neomutt's query_command opotion

set -e
set -u

function query_notmuch_to() {
    out=$(notmuch address to:"*$1*")
    out=$(echo "$out" | sed -E 's/^(.*) <([^>]+)>/\1\t"\2"\t/')
    out=$(echo "$out" | sed -E 's/^([^\t]*)\t([^\t]*)\t(.*)$/\1\t\2\t\3 notmuch/')
    echo "$out"
}

function query_notmuch_from() {
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

out+=$(query_notmuch_to "$@")
[[ -n $out ]] && out+=$'\n'

out+=$(query_notmuch_from "$@")
[[ -n $out ]] && out+=$'\n'

out+=$(query_khard "$@")

echo "$out"
