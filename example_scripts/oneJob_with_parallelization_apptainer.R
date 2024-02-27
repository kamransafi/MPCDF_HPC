library(doParallel)
registerDoParallel(8) ## this number has to be the same as "--cpus-per-task" in the slurm script
## read in data
df <- readRDS("~/myproject/mydata/testData.rds")
llply(1:nrows(df), function(x){
  dfsub <- df[x,]
  ## do something with it
  ## save the results
  saveRDS(dfsub, file=paste("~/myproject/myresults/saveDF_",1,".rds"))
},.parallel = TRUE)


