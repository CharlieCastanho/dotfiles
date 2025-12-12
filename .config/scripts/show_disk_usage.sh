#!/usr/bin/env bash

icon=" "
usage=$(df -h / | awk 'NR==2 {print $3 "/" $2}')

echo "$icon $usage"
