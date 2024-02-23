## read in data
df <- readRDS("~/myproject/mydata/testData.rds")
## do something with it
df <- df[1:2,]
## save the results
saveRDS(df, file="~/myproject/myresults/saveDF.rds") 

