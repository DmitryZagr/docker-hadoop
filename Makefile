DOCKER_NETWORK = hadoop
ENV_FILE = ./hadoop.env

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:1.2.1-hadoop2.8.1-java8 hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:1.2.1-hadoop2.8.1-java8 hdfs dfs -copyFromLocal /opt/hadoop-2.8.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:1.2.1-hadoop2.8.1-java8 hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:1.2.1-hadoop2.8.1-java8 hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:1.2.1-hadoop2.8.1-java8 hdfs dfs -rm -r /input

build-local:
	docker build -t dmitryzagr/hadoop-base:hadoop3.0.0-java8 ./base
	docker build -t dmitryzagr/hadoop-namenode:hadoop3.0.0-java8 ./namenode
	docker build -t dmitryzagr/hadoop-datanode:hadoop3.0.0-java8 ./datanode
	docker build -t dmitryzagr/hadoop-nodemanager:hadoop3.0.0-java8 ./nodemanager
	docker build -t dmitryzagr/hadoop-resourcemanager:hadoop3.0.0-java8 ./resourcemanager
	docker build -t dmitryzagr/hadoop-historyserver:hadoop3.0.0-java8 ./historyserver
push:
	docker push dmitryzagr/hadoop-base:hadoop3.0.0-java8
	docker push dmitryzagr/hadoop-namenode:hadoop3.0.0-java8
	docker push dmitryzagr/hadoop-datanode:hadoop3.0.0-java8
	docker push dmitryzagr/hadoop-nodemanager:hadoop3.0.0-java8
	docker push dmitryzagr/hadoop-resourcemanager:hadoop3.0.0-java8
	docker push dmitryzagr/hadoop-historyserver:hadoop3.0.0-java8
