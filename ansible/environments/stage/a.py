#!/usr/bin/env python

import sys
import inspect

sys.path.append('../python_libs')

import googleapiclient.discovery
from six.moves import input
import json

compute = googleapiclient.discovery.build('compute', 'v1')

#result = compute.instances().list(filter="name=reddit-db", project='fluted-elixir-234916', zone='europe-west1-b').execute()
if len(sys.argv) < 2:
    outstr = '{"_meta": {"hostvars": {}},"all": {"children": ["ungrouped"]},"ungrouped": {}}'
elif sys.argv[1] == "--list":
    result = compute.instances().list(project='fluted-elixir-234916', zone='europe-west1-b').execute()
    a = result['items'] if 'items' in result else None
    instances = {}
    for f in a:
        instances[f['name']] = (f['networkInterfaces'][0]['accessConfigs'][0]['natIP'], f['networkInterfaces'][0]['networkIP'])
    outstr = '{"_meta": {"hostvars": {"appserver": {"ansible_host": "%s"},"dbserver": {"ansible_host": "%s"}}},"app": {"hosts": ["appserver"]},"db": {"hosts": ["dbserver"]}}' % (instances['reddit-app'][0], instances['reddit-db'][0])

out = json.loads(outstr)
print(json.dumps(out,  indent=4, sort_keys=True))

