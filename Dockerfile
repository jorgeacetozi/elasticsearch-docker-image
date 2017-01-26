# Set the base image to java8
FROM openjdk:8-jre

# File Author / Maintainer
MAINTAINER Jorge Acetozi

# Define default environment variables
ENV ELASTICSEARCH_VERSION=2.3.5
ENV ELASTICSEARCH_HOME=/opt/elasticsearch
ENV ES_HEAP_SIZE=1024m
ENV IS_MASTER_ELEGIBLE_NODE=true
ENV IS_DATA_NODE=true
ENV LOCK_MEMORY=false
ENV MINIMUM_MASTER_NODES=1

# Create elasticsearch group and user
RUN groupadd -g 1000 elasticsearch \
  && useradd -d "$ELASTICSEARCH_HOME" -u 1000 -g 1000 -s /sbin/nologin elasticsearch

# Install Elasticsearch 2.3.5
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz -P /opt \
  && cd /opt \
  && tar xvzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
  && mv elasticsearch-$ELASTICSEARCH_VERSION elasticsearch \
  && rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
  && mkdir -p /var/data/elasticsearch \
  && mkdir -p /var/log/elasticsearch

WORKDIR $ELASTICSEARCH_HOME

# Add initialization script
ADD bin/docker-entrypoint.sh bin/docker-entrypoint.sh

# Add Elasticsearch template configuration file
ADD config/elasticsearch.yml config/elasticsearch.yml

# Change directories ownership to elasticsearch user and group
RUN chown -R elasticsearch:elasticsearch $ELASTICSEARCH_HOME /var/data/elasticsearch /var/log/elasticsearch

# Run the container as elasticsearch user
USER elasticsearch

# Install Elasticsearch monitoring plugins
RUN ./bin/plugin install mobz/elasticsearch-head \
  && ./bin/plugin install royrusso/elasticsearch-HQ

# Define mountable directories
VOLUME /var/data/elasticsearch
VOLUME /var/log/elasticsearch

# Exposes http ports
EXPOSE 9200 9300

# Define main command
ENTRYPOINT ["/opt/elasticsearch/bin/docker-entrypoint.sh"]
