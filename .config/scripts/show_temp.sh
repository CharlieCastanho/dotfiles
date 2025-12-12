#!/usr/bin/env bash

fan_icon="󰈐 "
temp_icon=" "

# First fan with RPM entry
rpm=$(sensors | awk '/fan[0-9]:/ {print $2; exit}')

# First CPU temp (usually "Tctl", "Package id 0", or "CPU")
temp=$(sensors | awk '/CPU:/ {print $2; exit}' | sed 's/+//')

echo "$fan_icon ${rpm} RPM | $temp_icon $temp"
