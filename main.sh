#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Конфигурация
source "$SCRIPT_DIR/config.sh"

# Библиотеки
source "$SCRIPT_DIR/lib/date.sh"
source "$SCRIPT_DIR/lib/wiki.sh"
source "$SCRIPT_DIR/lib/output.sh"


# Проверяем зависимости
for command in curl jq date; do
    if ! command -v "$command" &>/dev/null; then
        echo "Error: command '$command' not set."
        exit 1
    fi
done


# Получаем дату
get_date "$@"


# Заголовок
print_header


# Получаем данные Wikipedia
if ! DATA=$(get_wikipedia_data); then
    echo "Error: failed to retrieve data from Wikipedia API."
    exit 1
fi


# Выводим информацию
print_events "$DATA"
print_births "$DATA"
print_deaths "$DATA"
print_holidays "$DATA"
