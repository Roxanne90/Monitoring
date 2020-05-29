# R_code_snow.r

setwd("/Users/roxanechenmintao/lab")

install.packages("ncdf4")
library(raster)
library(ncdf4)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc") # warning message because it's a fraction of global map 

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Excercise: plot the snow cover with the color ramp palette

plot(snowmay, col=cl)


# Slow manner to import the set

setwd("Users/roxanechemintao/lab/snow")

snow2000<- raster("snow2000r.tif")
snow2005<- raster("snow2005r.tif")
snow2010<- raster("snow2010r.tif")
snow2015<- raster("snow2015r.tif")
snow2020<- raster("snow2020r.tif")

par(mfrow= c(2,3)) # par multiframe row= c(1, 2) 1 row 2 graphs

plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

####################

# Faster version of import and plot of many data for lazy people!

rlist <- list.files(pattern="snow") # make a list of all the files that include the word snow

import<- lapply(rlist, raster)  # lapply is to apply a certain function over a list or vector
snow.multitemp<- stack(import)  # stack to put them all together
plot(snow.multitemp, col=cl)

# Let's make a prediction
library(raster)
library(rgdal)

source("prediction.r") # file is in snow folder and the function source will run the code within the file







