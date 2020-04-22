# R code for remote sensing analysis

# raster
install.packages("raster")
install.packages("RStoolbox")

#
setwd("/Users/roxanechenmintao/lab/Remote_sensing.RData")

library(raster)

# importing a compact set of different bands (data from lab folder)

p224r63_2011<-brick("p224r63_2011_masked.grd") #grd means grid
plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) 

# Excercise: plot the image with the new color ramp palette

plot(p224r63_2011, col=cl)

# bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

#multiframe of different plots

par(mfrow=c(2,2)) # graph with two by two plots:two rows and two columns: grpah with four bands

#B1: blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)


#B2: green
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)


#B3: red
clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)


#B4: NIR
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)


dev.off()

# plotRGB

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # stretching the colors linear stretching
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Excercise NIR on top of the G component of the RGB # shows differences in vegetation and violet part are bare soil
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
