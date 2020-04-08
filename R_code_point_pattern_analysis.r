# Point pattern analysisi: Density map

install.packages("spatstat")
library(spatstat)

attach(covid)
covids <- ppp(lon,lat,c(-180,180),c(-90,90))     # c() is the cluster of numbers range of lon and lat respectively

# without attaching the covid set
#covids <- ppp(covid$lon,covid$lat,c(-180,180),c(-90,90))

d<-density(covids)

plot(d)
points(covids) #to have the points on top of density map

#----

setwd("/Users/roxanechenmintao/lab")
load("point_pattern.RData")

ls()
# covids: point pattern
# d: density map

library(spatstat)

plot(d)
points(covids)

install.packages("rgdal") # so that we can see the coastline data we just uploaded from iol
library(rgdal)

# let's input vector lines (x0y0,x1y1,x2y2,..)
coastlines<-readOGR("ne_10m_coastline.shp")   # need to be in capital letter (OGR)

plot(coastlines, add=T) #add means we add lines to the previous image otherwise it will remove the previous one

#let's make a palette

cl<- colorRampPalette(c('yellow','orange','red'))(100) # (c is cluster, density from red to yellow) (number=all possible colors from yellow to red)
plot(d, col=cl)
points(covids)
plot(coastlines,add=T)

# Excercise: new color ramp palette

clr<- colorRampPalette(c('light green','yellow','orange','violet'))(100)
plot(d, col=clr, main="Densities of covid-19")
points(covids)
plot(coastlines,add=T)

#number of colors
cll<-colorRampPalette(c("light green", "yellow", "orange, "violet"))(5)

# not enough colors, too abrupt change of colors!

# Export
pdf("covid_density.pdf")
clr<- colorRampPalette(c('light green','yellow','orange','violet'))(100)
plot(d, col=clr, main="Densities of covid-19")
points(covids)
plot(coastlines,add=T)
dev.off()



                        
                        
