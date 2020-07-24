#!/bin/sh

while 1; do
    status=$(curl -s -o /dev/null -w "%{http_code}" http://www.google.com/)
    time=$(date "+%Y-%m-%d %H:%M:%S")
    meta="OK"
    if [ "$status" != 200 ]; then
        meta="ERROR"
    fi
    printf "$time -> $status ($meta)\n"
    sleep 1
done