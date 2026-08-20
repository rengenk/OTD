#!/bin/bash

print_header() {
    echo
    echo "============================================"
    echo "     WHAT HAPPENED ON THIS DAY: $DAY.$MONTH"
    echo "============================================"
    echo
}

print_section() {
    local title="$1"
    local content="$2"

    echo "$title"

    if [[ -n "$content" ]]; then
        echo "$content"
    else
        echo "Нет данных."
    fi

    echo
}

print_events() {
    local data="$1"

    local events

    events=$(echo "$data" | jq -r '
        .events
        | sort_by(.year | tonumber)
        | .[]
        | "• \(.year) — \(.text)"
    ')

    print_section "EVENTS:" "$events"
}

print_births() {
    local data="$1"

    local births

    births=$(echo "$data" | jq -r '
        .births
        | sort_by(.year | tonumber)
        | .[]
        | "• \(.year) — \(.text)"
    ')

    if [[ "$DAY" == "04" && "$MONTH" == "11" ]]; then
        births="${births}"$'\n'"• 1998 - rengenk, DevOps-engineer (thats me lol :D)"
    fi

    births=$(printf '%s\n' "$births" |
        sort -n -t'|' -k1,1 |
        sed 's/^[^|]*|/• /')

    print_section "BIRTHS:" "$births"
}

print_deaths() {
    local data="$1"

    local deaths

    deaths=$(echo "$data" | jq -r '
        .deaths
        | sort_by(.year | tonumber)
        | .[]
        | "• \(.year) — \(.text)"
    ')

    print_section "DEATHS:" "$deaths"
}

print_holidays() {
    local data="$1"

    local holidays

    holidays=$(echo "$data" | jq -r '
        .holidays[]? |
        "• \(.text)"
    ')

    print_section "HOLIDAYS:" "$holidays"
}
