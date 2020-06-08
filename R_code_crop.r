### R_code_crop.r 

library(raster)
library(ncdf4)

snow <- raster(c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc)

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)

ext <- c(0, 20, 35, 50) # extent at which we zoom

zoom(snow, ext=ext)

# crop and create a new image

snowitaly <-crop(snow, ext)
plot(snowitaly, col=cl)
zoom(snow,ext=drawExtent()) # to crop the image into a rectangle, so basically it zooms the image to the part you want




