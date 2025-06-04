#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "deploy failed because you need to pass in the filename for the war"
fi

war_file="$1"

if [ -d $HOME/.tomcat-instance ] || [ -L $HOME/.tomcat-instance ]; then
    echo deploying war

    cp $war_file.war $HOME/.tomcat-instance/webapps/
    exit 0

    if [ "$(uname)" == "Darwin" ] && [ "$(~/.local/bin/tc-status)" == "RUNNING" ]; then
        sleep 2
        open http://localhost:8080/hhibkhtest
    fi
else
    echo "where\'s tomcat?"
fi

