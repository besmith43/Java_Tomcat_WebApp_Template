#!/usr/bin/env bash


echo building war file


if [ -z "$1" ]; then
    echo "build war failed because you need to pass in the filename for the war"
fi

war_file="$1"


if [ -d dist ]; then
	rm -r dist
	mkdir dist
fi

mkdir -p dist/WEB-INF/classes
mkdir -p dist/WEB-INF/lib
mkdir -p dist/META-INF/


cp -r web/* dist/

if [ -d lib ]; then
    cp lib/*.jar dist/WEB-INF/lib
fi

cp -r target/* dist/WEB-INF/classes/
cp src/conf/MANIFEST.MF dist/META-INF

cd dist

zip -r0 ../$war_file.war *




