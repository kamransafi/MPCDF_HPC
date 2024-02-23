## this 2 following lines are NOT to be changed
args <- commandArgs(trailingOnly = TRUE)
i <- as.numeric(args[1]) ## "i" will "go through" the numbers stated in #SBATCH --array= in the slurm file

## example code to run one instance per file, eg if you have one file per individual
library("move2")

pthInput <- "MyInputData/"
pthOutput <- "MyOutputData/"

rdsFilesList <- list.files(pthInput, full.names = T)
indv <- readRDS(file=rdsFilesList[i]) ## will read in a single file at a time

## do something

saveRDS(indv, file=paste0(pthOutput,"test_",unique(mt_track_id(indv)),".rds"))

## another example reading in single lines of a table at a time

