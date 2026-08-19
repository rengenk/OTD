#!/bin/bash

get_wikipedia_data() {
    local url

    url="${API_BASE}/${WIKI_LANG}/onthisday/all/${MONTH}/${DAY}"

    curl \
        --fail \
        --silent \
        --show-error \
        --connect-timeout "$CURL_CONNECT_TIMEOUT" \
        --max-time "$CURL_TIMEOUT" \
        -H "User-Agent: $USER_AGENT" \
        "$url"
}
