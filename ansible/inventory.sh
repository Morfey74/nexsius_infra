#!/usr/bin/env bash

if [ "$1" = "--list" ]; then
    APP_IP=`gcloud compute instances list --filter="name=('reddit-app')" | tail -1 | awk '{print $5}'`
    echo $APP_IP > ../app_ip.log
    DB_IP=`gcloud compute instances list --filter="name=('reddit-db')" | tail -1 | awk '{print $5}'`
    DB_INT=`gcloud compute instances list --filter="name=('reddit-db')" | tail -1 | awk '{print $4}'`

    sed -i~ "s/db_host:.*$/db_host:\ $DB_INT/g" "app.yml"
    rm -f app.yml~

    cat << _EOF_
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "${APP_IP}"
                },
                "dbserver": {
                    "ansible_host": "${DB_IP}"
                }
            }
        },
        "app": {
            "hosts": [
                "appserver"
            ]
        },
        "db": {
            "hosts": [
                "dbserver"
            ]
        }
    }
_EOF_
else
    cat << _EOF_
    {
        "_meta": {
                "hostvars": {}
        },
        "all": {
                "children": [
                        "ungrouped"
                ]
        },
        "ungrouped": {}
    }
_EOF_
fi
