#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"

source "$SCRIPT_DIR/lib/date.sh"
source "$SCRIPT_DIR/lib/wiki.sh"
source "$SCRIPT_DIR/lib/output.sh"

for command in curl jq date; do
    if ! command -v "$command" &>/dev/null; then
        echo "Error: command '$command' not set."
        exit 1
    fi
done

get_date "$@"

print_header

if ! DATA=$(get_wikipedia_data); then
    echo "Error: failed to retrieve data from Wikipedia API."
    exit 1
fi

print_events "$DATA"
print_births "$DATA"
print_deaths "$DATA"
print_holidays "$DATA"
