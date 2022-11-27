#!/usr/bin/env bash

# set options to exit if something fails
set -o errexit
set -o nounset
set -o pipefail

# check debug flag
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# print help
if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo \
'Usage: ./create-viz.sh
Debug: TRACE=1 ./create-viz.sh

This script will visualise your file structure history

'
    exit
fi

main() {
    FOLDERNAME="folder-structure-history"

    # create folder if it does not exist
    if [ ! -d "$FOLDERNAME" ]; then
        mkdir $FOLDERNAME
    fi

    echo "creating visualisation"

    COUNTER=$(git log --pretty="format:%H" | wc -l)
    git log --pretty="format:%H" | awk 1 | while read COMMIT_HASH
    do
        git ls-tree -r $COMMIT_HASH --name-only | tree --fromfile . > "$FOLDERNAME/$COUNTER-$COMMIT_HASH.txt"
        let COUNTER=COUNTER-1
    done
}

main "$@"
