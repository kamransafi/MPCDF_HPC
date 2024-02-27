args <- commandArgs(trailingOnly = TRUE)
i <- as.numeric(args[1]) ## "i" will "go through" the numbers stated in "#SBATCH --array=" in the slurm file

## example code to run one instance per file, eg if you have one file per individual
library("move2")

pthInput <- "MyInputDataFile/"
pthOutput <- "MyResultsDataFile/"

rdsFilesList <- list.files(pthInput, full.names = T)
indv <- readRDS(file=rdsFilesList[i]) ## will read in a single file at a time

## do something
## save resutls
saveRDS(indv, file=paste0(pthOutput,"result_",unique(mt_track_id(indv)),".rds"))

## another example reading in single lines of a table at a time
df <- readRDS("~/myproject/mydata/testData.rds")
dfsub <- df[i,]
## do something
## save the results
saveRDS(dfsub, file=paste0("~/myproject/myresults/saveDF_",i,".rds"))