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


################


setwd("/Users/roxanechenmintao/lab/Remote_sensing2.RData")

load("rs.RData")
ls()

library(raster)
p224r63_1988<-brick("p224r63_1988_masked.grd") 

plot(p224r63_1988)

# plot RGB
# bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR


# Excercise: plot in visible RGD 321 both images
par(mfrow=c(2,1)) 
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

# Excercise: plot in visible RGD 432 both image
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Enhance the noise ! (on these images)
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#
# bands of Landsat
#B1: blue
#B2: green
#B3: red: B3_sre
#B4: NIR: B4_sre

dvi2011<- p224r63_2011$B4_sre - p224r63_2011$B3_sre
clr <- colorRampPalette(c('darkorchid3','light blue','light pink4'))(100) 
plot (dvi2011)

#Excercise: dvi for 1988
dvi1988<- p224r63_1988$B4_sre - p224r63_1988$B3_sre
clr <- colorRampPalette(c('darkorchid3','light blue','light pink4'))(100) 
plot (dvi1988)


# difference from one year to the other
diff<- dvi2011 - dvi1988
plot(diff)


# changing the grain!
#resampling
p224r63_2011res<-aggregate(p224r63_2011, fact=10) 
p224r63_2011res100<-aggregate(p224r63_2011, fact=100) 

par(mfrow=c(3,1))

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")
 
