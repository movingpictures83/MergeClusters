library(SINCERA)
library(cluster)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
	## first iteration
sc <- readRDS(paste(pfix, parameters["clusters", 2], sep="/"))
# we merged the two clusters
cluster.1 <- getCellMeta(sc, "CLUSTER")
cluster.1[which(cluster.1==as.integer(parameters["cluster2", 2]))]=as.integer(parameters["cluster1", 2])
sc <- setCellMeta(sc, name="CLUSTER.1", value=cluster.1)
sc <- copyCellMeta(sc, "CLUSTER.1", "GROUP")
saveRDS(sc, outputfile)
}
