#!/usr/bin/env bash

if [ "$1" = "--list" ]; then
    APPIP=`gcloud compute instances list --filter="name=('reddit-app')" | tail -1 | awk '{print $5}'`
    DBIP=`gcloud compute instances list --filter="name=('reddit-db')" | tail -1 | awk '{print $5}'`
    cat << _EOF_
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "${APPIP}"
                },
                "dbserver": {
                    "ansible_host": "${DBIP}"
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
