#! bin/bash

sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install openjdk-8-jdk
wget https://mirrors.koehn.com/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz -P ~/Downloads
sudo tar zxvf ~/Downloads/hadoop-* -C /usr/local
sudo rm -rf ~/Downloads/hadoop-*
sudo mv /usr/local/hadoop-* /usr/local/hadoop
export JAVA_HOME=/path/to/java
export PATH=$PATH:$JAVA_HOME/bin
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
source ~/.bashrc