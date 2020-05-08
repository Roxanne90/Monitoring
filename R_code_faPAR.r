# install.packages("raster")

 

library(raster)
library(rasterVis)
library(rasterdiv)
 
 
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)
 

setwd(Users/roxanechenmintao/lab)
 
faPAR10 <- raster("faPAR10.tif")

levelplot(faPAR10)
 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

 

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

 
 
