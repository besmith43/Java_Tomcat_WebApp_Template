#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "deploy failed because you need to pass in the filename for the war"
fi

war_file="$1"

if [ -d $HOME/.tomcat-instance ] || [ -L $HOME/.tomcat-instance ]; then
    echo deploying war

    cp $war_file.war $HOME/.tomcat-instance/webapps/
else
    echo "where\'s tomcat?"
fi

