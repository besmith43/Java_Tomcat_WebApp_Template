#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "publish failed because you need to pass in the ssh server name" >&2
    exit 1
fi

ssh_server="$1"

tomcat_log_dir="/opt/tomcat/base/logs"

if [ -d logs ]; then
    rm -r logs
fi

ssh $ssh_server sudo cp -r $tomcat_log_dir /home/besmith || exit 1
ssh $ssh_server sudo tar -cvf tomcat_logs.tar.gz logs || exit 1
scp $ssh_server:tomcat_logs.tar.gz . || exit 1

ssh $ssh_server sudo rm -r logs tomcat_logs.tar.gz || exit 1

tar -xvf tomcat_logs.tar.gz || exit 1

rm tomcat_logs.tar.gz || exit 1

