## R script to test small Hadoop MapReduce Jobs in RStudio.

#Set Envroiment Variables
Sys.setenv(HADOOP_OPTS="-Djava.library.path=/usr/local/hadoop/lib/native")
Sys.setenv(HADOOP_HOME="/usr/local/hadoop")
Sys.setenv(HADOOP_CMD="/usr/local/hadoop/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.5.jar")
Sys.setenv(JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64")
Sys.setenv(HADOOP_OPTS="-Djava.library.path=/usr/local/hadoop/lib/native")
Sys.setenv(HADOOP_HOME="/usr/local/hadoop")
Sys.setenv(HADOOP_CMD="/usr/local/hadoop/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.5.jar")
Sys.setenv(JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64")

#Install and load Hadoop Libraries
install.packages("rhdfs")
install.packages("rmr2")

library(rhdfs)
library(rmr2)
hdfs.init()


# Use Iris dataset to count different species
hdfs_input = to.dfs(iris$Species)

mapreduce_job = from.dfs(
  mapreduce(
    input = hdfs_input, 
    map = function(., v) keyval(v, 1), 
    reduce = 
      function(k, vv) 
        keyval(k, length(vv))))

result = as.data.frame(cbind(mapreduce_job$key, mapreduce_job$val))

