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

plot(predicted.snow.2025.norm, col=cl)
     
    
###########################     
## Day 2

setwd("/Users/roxanechenmintao/lab/snow/") 

# Excercise: import the snow cover images altogether

rlist <- list.files(pattern="snow")
import<- lapply(rlist, raster) 
snow.multitemp<- stack(import) 
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)

# load("snow.RData")

prediction<- raster("predicted.snow.2025.norm.tif")

plot(prediction, col=cl)

# export the output
# you made the calculation and you want to send the output to a colleague

writeRaster(prediction,"final.tif") #writeRaster function makes it into a file you choose + title in "" 

#final stack altogether

final.stack<- stack(snow.multitemp, prediction) # stack of snow images + the prediction = 6 images in total

plot(final.stack, col=cl)

# export the R graph for your beautiful thesis! 

pdf("my_final_exciting_graph.pdf")
plot(final.stack, col=cl)
dev.off() # very important!!! Need to close the window to open the pdf

png("my_final_exciting_graph.png")
plot(final.stack, col=cl)
dev.off()


