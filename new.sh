#!/bin/sh

: "Setup" && {
    [ "$#" -eq 0 ] && {
        echo "Usage: $0 suffix for new post"
        exit 1
    }

    for arg in "$@"; do
        echo "$arg" | grep -Eq '^[0-9a-zA-Z]+$' || {
            echo "Error: Only alphanumeric characters are allowed."
            exit 1
        }
    done

    set -- "$(echo "$@" | tr '[:upper:]' '[:lower:]')"

    s=$(printf "_%s" "$@" | tr ' ' '_')
    s=${s#_}

    posts=$(dirname "$0")/posts
    dir="${posts}/$(date +%Y%m%d)_${s}"
    mkdir -p "${dir}"
    cp -r "${posts}/template/" "${dir}/"
}

: Edit && {
    vi "${dir}/main.md"
}
