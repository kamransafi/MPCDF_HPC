## read in data
df <- readRDS("~/myproject/mydata/testData.rds")
## do something with it
dfsub <- df[1:2,]
## save the results
saveRDS(dfsub, file="~/myproject/myresults/saveDF.rds") 

