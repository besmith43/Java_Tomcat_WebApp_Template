#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "publish failed because you need to pass in the filename for the sqlite db" >&2
fi

project_name="$1"

if [ -z "$2" ]; then
    echo "publish failed because you need to pass in the ssh server name" >&2
    exit 1
fi

ssh_server="$2"

db_file="$project_name.db"
tomcat_db_dir="/opt/tomcat/base/db"


scp db/$db_file $ssh_server: || exit 1
ssh $ssh_server sudo mv $db_file $tomcat_db_dir/ || exit 1
ssh $ssh_server sudo chown tomcat: $tomcat_db_dir/$db_file || exit 1



