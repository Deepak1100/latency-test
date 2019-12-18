#!/usr/bin/env python
from __future__ import print_function

import os
import sys
import time
import amazondax
import botocore.session

region = 'ap-southeast-1'

session = botocore.session.get_session()
dynamodb = session.create_client(
    'dynamodb', region_name=region)  # low-level client

table_name = "latency-test"

if os.getenv("DAX_ENDPOINT") != None:
    endpoint = os.getenv("DAX_ENDPOINT")
    print(endpoint)
    dax = amazondax.AmazonDaxClient(
        session, endpoints=[endpoint], region_name=region)
    client = dax
else:
    client = dynamodb

print("test")
iterations = 50
start = time.time()
for i in range(1, iterations):
    params = {
        'TableName': table_name,
        'Key': {
            "id": {'S': 'id-{}'.format(i)}
        }
    }
    result = client.get_item(**params)
    print('.', end='', file=sys.stdout)
    sys.stdout.flush()
print()

end = time.time()
print('Total time: {} sec - Avg time: {} sec'.format(end -
                                                     start, (end-start)/iterations))
