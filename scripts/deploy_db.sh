#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "deploy failed because you need to pass in the filename of the sqlite db"
fi

db_file="$1"

if [ -d $HOME/.tomcat-instance/db ]; then
    echo deploying db

    cp db/$db_file.db $HOME/.tomcat-instance/db/
else
    echo "where\'s tomcat?"
fi

