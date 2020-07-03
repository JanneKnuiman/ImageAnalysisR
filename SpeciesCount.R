## R script to do small Hadoop MapReduce Jobs in RStudio.

#Load Hadoop Libraries
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

#Show table with number of different species
result = as.data.frame(cbind(mapreduce_job$key, mapreduce_job$val))

