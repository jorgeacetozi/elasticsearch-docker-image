# Elasticsearch 5.6.6 Docker Image

## Bootstrap a 3-node Elasticsearch cluster using Vagrant
Just clone this GitHub repository and execute `vagrant up`!

- `$ git clone git@github.com:jorgeacetozi/elasticsearch-docker-image.git`
- `$ cd elasticsearch-docker-image/vagrant`
- `$ vagrant up`

Issue an HTTP GET to `http://10.0.0.10:9200/` and... You Know, for Search ;)

## How to increase Elasticsearch memory heap size?
Just tune `Xms` and `Xmx` values in `jvm.options` configuration file.

## How to backup data and log files using volumes?
Just use the `-v` instruction in the **docker container run** instruction:
- Elasticsearch Data: `docker container run... -v your_data_directory:/var/data/elasticsearch ...`
- Elasticsearch Logs: `docker container run... -v your_log_directory:/var/log/elasticsearch ...`

## Docker Container Run Parameters
This image support some level of customization by using environment variables in the `docker container run` instruction to dynamically modify the `elasticsearch.yml` configuration file:
- **CLUSTER_NAME**: set the cluster name (should be the same among all nodes in the cluster)
- **NODE_NAME**: specific name of the node itself.
- **NETWORK_HOST**: the IP that the node will publish itself so that other nodes can reach it. For instance, in Vagrant it must be the VM instance IP. In AWS it must be the EC2 instance private IP, and so on. When running Docker locally you don't need to specify it because both containers will run in the same host.
- **UNICAST_HOSTS**: the list of cluster initial nodes using the format **IP:PORT, IP:PORT, IP:PORT**
