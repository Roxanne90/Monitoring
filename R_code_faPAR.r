# install.packages("raster")

 

library(raster)
library(rasterVis)
library(rasterdiv)
 
 
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)
 

setwd(Users/roxanechenmintao/lab)
 
faPAR10 <- raster("view.php.tif")

levelplot(faPAR10)
 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

################ day 2

library(ratser)
library(rastediv)
library(rasterVis)

setwd("Users/utente/lab")
load("faPAR.RData")

# the original faPAR from Copernicus is 2GB
# Let's see how much space is needed for 8-bit set

writeRaster(copNDVI, "copNDVI.tif")

#5.5mb
#faPAR: levelplot this set

faPAR10 <- raster("copNDVI.tif")
levelplot(faPAR10)

