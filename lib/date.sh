#!/bin/bash

get_date() {
    if [[ $# -eq 0 ]]; then
        DAY=$(date +%d)
        MONTH=$(date +%m)

    elif [[ $# -eq 2 ]]; then
        DAY="$1"
        MONTH="$2"

        DAY=$((10#$DAY))
        MONTH=$((10#$MONTH))

        printf -v DAY "%02d" "$DAY"
        printf -v MONTH "%02d" "$MONTH"

    else
        echo "Usage:"
        echo "  $0"
        echo "  $0 DAY MONTH"
        exit 1
    fi

    if ! date -d "2026-$MONTH-$DAY" &>/dev/null; then
        echo "Error: incorrect date: $DAY.$MONTH"
        exit 1
    fi
}
