#!/bin/sh

frequency=1

#how often to check (seconds)
if [ $# == 1 ]; then
	frequency=$1
fi

while true; do
    status=$(curl -s -o /dev/null -w "%{http_code}" http://www.google.com/)
    time=$(date "+%Y-%m-%d %H:%M:%S")
    meta="OK"
    if [ "$status" != 200 ]; then
        meta="ERROR"
    fi
    printf "$time -> $status ($meta)\n"
    sleep $frequency
done