#!/usr/bin/env bash


# echo "publish the war file and nginx conf to the vps"
# echo "this will also need to restart nginx and tomcat services on the vps"

# required for nginx to be able to talk to localhost
# /usr/sbin/setsebool -P httpd_can_network_connect true


if [ -z "$1" ]; then
    echo "publish failed because you need to pass in the filename for the war" >&2
    exit 1
fi

project_name="$1"

if [ -z "$2" ]; then
    echo "publish failed because you need to pass in the ssh server name" >&2
    exit 1
fi

ssh_server="$2"

config_file="$project_name.conf"
war_file="$project_name.war"
nginx_config_path="/etc/nginx/conf.d"
tomcat_context_xml="/opt/tomcat/base/conf/context.xml"
project_context="conf/tomcat_context.xml"

if [ "$(ssh $ssh_server getsebool httpd_can_network_connect)" != "httpd_can_network_connect --> on" ]; then
    echo "httpd can network connect is off" >&2
    echo "that's bad" >&2
    echo "you need to run the following command as root:" >&2
    echo >&2
    echo "    /usr/sbin/setsebool -P httpd_can_network_connect true" >&2
    echo >&2
    exit 1
fi

scp conf/$config_file $ssh_server: || exit 1
ssh $ssh_server sudo mv $config_file $nginx_config_path/ || exit 1
ssh $ssh_server sudo chown root: $nginx_config_path/$config_file || exit 1
ssh $ssh_server sudo chcon -t httpd_config_t $nginx_config_path/$config_file || exit 1
ssh $ssh_server sudo systemctl restart nginx || exit 1

scp $war_file $ssh_server: || exit 1
ssh $ssh_server sudo chown tomcat: $war_file || exit 1
ssh $ssh_server sudo mv $war_file /opt/tomcat/base/webapps || exit 1


if [ -f $project_context ]; then

    new_contents="$(cat $project_context)"

    ssh $ssh_server sudo cp $tomcat_context_xml /home/besmith || exit 1
    scp $ssh_server:context.xml . || exit 1
    ssh $ssh_server sudo rm context.xml || exit 1

    if [[ "$(cat context.xml)" != *"$new_contents"* ]]; then
        awk 'NR==37{system("cat conf/tomcat_context.xml")}1' context.xml > tmp.xml && mv tmp.xml context.xml
        scp context.xml $ssh_server: || exit 1
        ssh $ssh_server sudo mv context.xml $tomcat_context_xml || exit 1
        ssh $ssh_server sudo chown tomcat: $tomcat_context_xml || exit 1
    fi

    rm context.xml || exit 1
fi

