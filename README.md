# Bootstrap a 2-node Elasticsearch cluster locally using Docker
- **Start node1**

`$ docker rm -f node1 || true && docker run -d --name node1 --net=host --privileged -p 9200-9400:9200-9400 -e CLUSTER_NAME=my-cluster -e NODE_NAME=node1 -e ES_HEAP_SIZE=512m jorgeacetozi/elasticsearch:2.3.5`

- **Start node2**

`$ docker rm -f node2 || true && docker run -d --name node2 --net=host --privileged -p 9200-9400:9200-9400 -e CLUSTER_NAME=my-cluster -e NODE_NAME=node2 -e ES_HEAP_SIZE=512m jorgeacetozi/elasticsearch:2.3.5`

Now just issue `http://localhost:9200/_plugin/head` in the browser.

# Bootstrap a 3-node Elasticsearch cluster using Vagrant
Just clone my GitHub repository and vagrant up!

- `$ git clone git@github.com:jorgeacetozi/elasticsearch-docker-image.git`
- `$ cd elasticsearch-docker-image/vagrant`
- `$ vagrant up`

Now just issue `http://10.0.0.10:9200/_plugin/head` in the browser.

# How to increase Elasticsearch memory heap size?
Just tune the **ES_HEAP_SIZE** environment variable in the **docker run** statement in order to fit your needs. For instance:
- **Increase the JVM Heap Size to 2048m:** "docker run ... -e ES_HEAP_SIZE=2048m ..."

# How to backup data and log files using volumes?
Just use the `-v` instruction in the **docker run** instruction:
- Elasticsearch Data: `docker run... -v your_data_directory:/var/data/elasticsearch ...`
- Elasticsearch Logs: `docker run... -v your_log_directory:/var/log/elasticsearch ...`

# Docker Run Parameters
This image support some level of customization by using environment variables in the `docker run` instruction to dynamically modify the `elasticsearch.yml` configuration file:
- **CLUSTER_NAME**: set the cluster name (should be the same among all nodes in the cluster)
- **NODE_NAME**: specific name of the node itself
- **ES_HEAP_SIZE**: modify JVM memory heap size
- **NETWORK_HOST**: the IP that the node will publish itself so that other nodes can reach it. For instance, in Vagrant it must be the VM instance IP. In AWS it must be the EC2 instance private IP, and so on. When running Docker locally you don't need to specify it because both containers will run in the same host
- **UNICAST_HOSTS**: the list of cluster initial nodes using the format **IP:PORT, IP:PORT, IP:PORT**
