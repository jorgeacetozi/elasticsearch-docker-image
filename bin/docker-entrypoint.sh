#!/bin/bash
set -e

sed -i "s/CLUSTER_NAME/$CLUSTER_NAME/
  s/NODE_NAME/$NODE_NAME/
  s/NETWORK_HOST/$NETWORK_HOST/
  s/UNICAST_HOSTS/$UNICAST_HOSTS/" ./config/elasticsearch.yml

echo -e "Starting Elasticsearch $ELASTICSEARCH_VERSION"
exec /opt/elasticsearch/bin/elasticsearch
