#!/usr/bin/env bash


if [ ! -d ~/.tomcat-instance/conf ]; then
    echo "tomcat base conf directory is missing"
    exit 1
fi


if [ ! -f conf/tomcat_context.xml ]; then
    echo "partial tomcat context xml file is missing"
    exit 1
fi

line_count="$(wc -l conf/tomcat_context.xml)"
new_contents="$(cat conf/tomcat_context.xml)"

# cp ~/.tomcat-instance/conf/context.xml .

if [[ "$(cat context.xml)" == *"$new_contents"* ]]; then
    echo new contents are in context.xml
    exit 0
fi

echo new contents are missing



# sed -i '38r conf/tomcat_context.xml' context.xml || exit 1
awk 'NR==38{system("cat conf/tomcat_context.xml")}1' context.xml > tmp.xml && mv tmp.xml context.xml


