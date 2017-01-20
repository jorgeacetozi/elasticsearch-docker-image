#!/bin/bash
set -e

sed -i "s/CLUSTER_NAME/$CLUSTER_NAME/" ./config/elasticsearch.yml
sed -i "s/NODE_NAME/$NODE_NAME/" ./config/elasticsearch.yml
sed -i "s/NETWORK_HOST/$NETWORK_HOST/" ./config/elasticsearch.yml
sed -i "s/UNICAST_HOSTS/$UNICAST_HOSTS/" ./config/elasticsearch.yml

echo -e "Starting Elasticsearch $ELASTICSEARCH_VERSION"
exec /opt/elasticsearch/bin/elasticsearch
