# Prereq: Find the build-log.properies file of your Intellij and change rootLogger's log-level from info to debug.

#/bin/sh

INTELLIJ_LOGS_DIR="$HOME/.cache/JetBrains/IntelliJIdea2021.3/log"

cd "$INTELLIJ_LOGS_DIR"

if [[ $? != 0 ]]; then
    exit 1
fi

if [[ $1 == "idea" ]]; then
    tail --follow=name -n 1000 "idea.log"
elif [[ $1 == "DEBUG" ]]; then
    tail --follow=name -n 1000 "build-log/build.log" 
else
    tail --follow=name -n 1000 "build-log/build.log" | grep -v "DEBUG"
fi