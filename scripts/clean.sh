#!/usr/bin/env bash


echo running clean


if [ -z "$1" ]; then
    echo "clean failed because you need to pass in the filename for the war"
fi

war_file="$1"

if [ -f $war_file.war ]; then
    rm $war_file.war
fi

if [ -d target ]; then
	rm -r target
	mkdir target
fi


if [ -d dist ]; then
	rm -r dist
	mkdir dist
fi


if [ -n "*.log" ]; then
    rm -f *.log
fi

