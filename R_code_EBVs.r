# R_code_EBVs.r

setwd("Users/roxanechenmintao/lab")

# install.packages("raster")
# install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA

snt <- brick("snt_r10.tif")

plot(snt)

# B1 brue
# B2 green
# B3 red
# B4 NIR

# R3 G2 B1
plotRGB(snt,3,2,1, stretch="lin")
plotRGB(snt,4,3,2, stretch="lin")
pairs(snt)


### PCA analysis
sntpca<- rasterPCA(snt_r)

summary(sntpca$model)

#70% of information
plot(sntpca$map)

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

# set the moving window
window <- matrix(1, nrow = 5, ncol = 5)

sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")


############### day2: Cladonia example

library(raster)
library(RStoolbox)
setwd("/Users/roxanechenmintao/lab")

# two ways to import file: raster or brick
## raster function imports one single layer
### brick function imports several layers at a time

clad <- brick("cladonia_stellaris_calaita.JPG")

plotRGB(clad, 1, 2, 3, stretch="lin") 

window<- matrix (1, nrow=3, ncol=3) # 3 by 3 matrix


### PCA analysis
cladpca<-rasterPCA(clad)

summary(cladpca$model)
#98%

plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

## set the moving window

sd_clad<- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg<- aggregate(cladpca$map$PC1, fact=10) #to accelerate the calculation of standard deviation

sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

par(mfrow=c(1,2)) #2graphs in the same row
cl <- colorRampPalette(c('yellow','violet','black'))(100)

plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# the image shows us all micro-variation within the structure of cladonia can be measured

# plot the calculation
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)
 
