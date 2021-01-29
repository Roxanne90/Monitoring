# R_code_exam.r
# 1.  R_code_first.r
# 2.  R_code_spatial.r
# 3.  R_code_Multipanel.r
# 4.  R_code_Multivariate.r 
# 5.  R_code_remote_sensing.r
# 6.  R_code_rs.r
# 7.  R_code_no2.r
# 8.  R_code_pca_remote_sensing.r
# 9.  R_code_point_pattern_analysis.r
# 10. R_code_radiance.r
# 11. R_code_sdm.r
# 12. R_code_snow.r
# 13. R_code_faPAR.r
# 14. R_code_ecosystem_functions.r
# 15. R_code_crop.r 
# 16. R_code_interpolation.r
# 17. R_code_EBVs.r
# 18. R_code_project.r

#####################################################
#####################################################

# R_code_first.r

install.packages("sp")

library(sp)
data(meuse)

#Let's see how the meuse dataset is structured:
meuse

#let's look at the first row of the set
head(meuse)

#let's plot two variables
#let's see if the zinc concntration is related to that of copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="green")
plot(zinc,copper,col="green",pch=19)
plot(zinc,copper,col="green",pch=19,cex=2)

#####################################################
#####################################################

# R_code_spatial.r

install.packages("sp")
library(sp)

data(meuse)

head(meuse)

# coordinates
coordinates(meuse)=~x+y.   #this explains to meuse that we will explore spacially

plot(meuse) #plot is just points in space

spplot(meuse,"zinc") #spplot means according to a variable

# Excercise: plot the spatial amount of copper 

spplot(meuse,"copper",main="Copper concentration") # main is to put a title for the plot


bubble(meuse, "zinc") #bubble is to make use of size of concentration rather than points of color 
bubble(meuse, "zinc", main="Zinc cocnentration") # bubble is plot with different size of points

# Excercise: bubble copper in red
bubble(meuse, "copper", col="red", main="Copper concentration")

#### importing new data

# download covid_agg.csv from IOL and build folder called lab into C:or home
# put the covid_agg.csv file into the folder lab

# Setting the working directory:lab
#Windows
setwd("c:/lab/")
# Mac
setwd("/Users/roxanechenmintao/lab/")
#Linux users
setwd("~/lab")

covid<-read.table("covid.php.csv",head=T)  
head(covid)

attach(covid) 
plot(country,cases)

# if you dont attach covid, the plot should be written like this: plot(covid$country,covid$cases) 

plot(country,cases, las=0) #las is labels ##parallele labels
plot(country,cases, las=1) #horizontal labels
plot(country,cases, las=2) #perpendicular labels
plot(country,cases, las=3) #vertical labels

plot(country,cases, las=3, cex.axis=0.5) 

# ggplot2 package
install.packages("ggplot2")

library(ggplot2) #another function is require(ggplot2) #library is to say we want to use it

# save the .Rdata under the menu file

# load previously saved .RData
# Setting the working directory:lab
#Windows
setwd("c:/lab/")
# Mac
setwd("/Users/roxanechenmintao/lab/")
#Linux users
setwd("~/lab")

load("test 1")

ls() # means 'list' this shows all the data that was made
# covid

install.packages(ggplot2)
library(ggplot2) #require(ggplot2)

data(mpg)
head(mpg)
# key components: data, aesthetics, geometry # geometry is a seperate file
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() #need the () for all the functions
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon()

head(covid)
ggplot(covid, aes(x=lon, y=lat, size=cases))+geom_point() #size of point will be according to cases


#####################################################
#####################################################

# R_code_Multipanel.r

install.packages("sp")
install.packages("GGally") # this is used for the function ggpairs()

library(sp) # require(sp) will also do the job
library(GGally)

data(meuse) # there is a dataset available named meuse

attach(meuse)

# Excercise: see the names of the variables and plot cadmium versus zinc

# There are two ways to see the names of the variables:
names(meuse)
head(meuse)
plot(cadmium,zinc,pch=15,col="red",cex=2)

# Excercise: make all the possible pairwise plots of the dataset
# plot(x,cadmium)
# plot(x,zinc)
# plot...
# plot is not a good idea!!!

pairs(meuse)

# in case you receive the error "the size is too large" reshape the graph window and relaunch the code

#switch to all variables to just four variables
pairs(~cadmium+copper+lead+zinc,data=meuse)

# or another way:
pairs(meuse[,3:6])

# Excercise: prettify this graph

pairs(meuse[,3:6],pch=18,col="purple",cex=1.5)

# Let's impress our classmates
install.packages("GGally")
library(GGally)

#GGally package will prettify the graph
ggpairs(meuse[,3:6])

#####################################################
#####################################################

# R_code_Multivariate.r 

setwd("Users/roxanechenmintao/lab")

# install.packages("vegan")
library(vegan)

biomes<-read.table("biomes plot.php.csv", head=T, sep=",")
head(biomes)     #view(biomes), biomes

# Multivariate analysis
# decorana means DEtrended CORrespondants ANAlysis, we can see the data in 2 dimensions

multivar <- decorana(biomes) 
multivar
plot(multivar)
# plot(multivar, cex=1.2)

#biomes types
biomes_types <- read.table("biomes types.php.csv",head=T,sep=",")
head(biomes_types)

attach(biomes_types)

# Linking one point to the other #ellipse connects all the points of the plots attaining to a certain biome
# col=4 different colors/biomes, kind= kind of graph (ehull type), lwd+ dimension of line

ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=2)
 
 # col=c("green", "blue", "red", "black")
 
ordispider(multivar, type, col=1:4, label = T)


#####################################################
#####################################################

#R_code_remote_sensing.r


#install.packages("RStoolbox")
library(raster)
library(RStoolbox)
library(ggplot2)

setwd(Users/name/lab)

p224r63_2011<- brick("p224r63_2011_masked.grd")      # to import all data of satellite images
#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR
#b6 thermal infrared
#b7 SWIR
#b8 panchromatic

# RGB:

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_2011,5, 4, 3)

# do the same with the 1988 image !

p224r63_1988<- brick("p224r63_1988_masked.grd") 
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_1988,5, 4, 3)

par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")


names(p224r63_2011)
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"

#dev.off()

plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre) #to see if bands are correlated with eachother, and they are!


### pca principle component  
# decrease the resolution
p224r63_2011_res<- aggregate(p224r63_2011, fact=10)

#library(RStollbox) is now needed...
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
## then just put the name of the pca to look at all the info

plot(p224r63_2011_pca$map)

cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$model) # to see the cumulative proportion

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# 1988

p224r63_1988_res<- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)

plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model) # also high correlation among the different bands
#99.56% by PC1

pairs(p224r63_1988)

#difference

difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map

plot(difpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100) #

plot(difpca$PC1,col=cldif)

###############################################################
###############################################################
# R_code_rs.r
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
 
################################################
################################################
# R_code_no2.r

setwd("/Users/roxanechenmintao/lab/no2")

# Excercise: import all of the NO2 data in R by the lapply function

library(raster)

rlist <- list.files(pattern="EN")
import<- lapply(rlist, raster)
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN, col=cl)

# January and march

par(mfrow=c(1,2))

plot(EN$EN_0001, col=cl) # $ sign to link the first image
plot(EN$EN_0013, col=cl)

# RGB space
plotRGB(EN, r=1, g=7, b= 13, stretch="lin") #(image we use, red=first image, green 7image, blue last image )

# SUPER FANCY image!! (basically in red=highest values in the first image: high amount of NO2 in Juanuary, then becomes lower as we reach March: the last image b=13) 

#### difference map between the first and last image #(however they may not be the best ones to choose)

dif<- EN$EN_0013 - EN$EN_0001 # $ to link each stack
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cld)


### Box plot using student age data

mean(c(22,23,24,24,24)) #mean=23.4 # median=24

#lets add the professor's age
mean(c(22,23,24,24,24,44)) #mean=27 # median=24

# Therefore with outliers data, the mean might not be reliable
# Whereas the median remains reliable even considering outliers

####### Lets use the NO2 data to make a boxplot
# Quantitative estimate!
boxplot(EN)

boxplot(EN, outline=F) # to remove the outliers
boxplot(EN, outline=F, horizontal=T) # to make the boxplot horizontal
boxplot(EN, outline=F, horizontal=T, axes=T) # add axes

# Plot! (anotherway to see the difference between the first and last image)
plot(EN$EN_0001, EN$EN_0013)
abline(0,1, col="red")  # The ab line is to see the one to one line to more clearly see the high and medium values a=0 and b=1

# under the curve its decreasing if over the curve its increasing


####### 1:1 line with snow data

setwd("Users/roxanechemintao/lab/snow")

rlist <- list.files(pattern="snow20") 
import<- lapply(rlist, raster) 
snow.multitemp<- stack(import) 

plot(snow.multitemp$snow2010r,snow.multitemp$snow2020r)
abline(0, 1, col="red")

plot(snow.multitemp$snow2000r,snow.multitemp$snow2020r)
abline(0, 1, col="red")
# high values of snow cover are always under the line, which means there is a decrease of snow cover

################################################
################################################
# R_code_pca_remote_sensing.r

#install.packages("RStoolbox")
library(raster)
library(RStoolbox)
library(ggplot2)

setwd(Users/name/lab)

p224r63_2011<- brick("p224r63_2011_masked.grd")      # to import all data of satellite images
#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR
#b6 thermal infrared
#b7 SWIR
#b8 panchromatic

# RGB:

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_2011,5, 4, 3)

# do the same with the 1988 image !

p224r63_1988<- brick("p224r63_1988_masked.grd") 
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_1988,5, 4, 3)

par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")


names(p224r63_2011)
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"

#dev.off()

plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre) #to see if bands are correlated with eachother, and they are!


### pca principle component  
# decrease the resolution
p224r63_2011_res<- aggregate(p224r63_2011, fact=10)

#library(RStollbox) is now needed...
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
## then just put the name of the pca to look at all the info

plot(p224r63_2011_pca$map)

cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$model) # to see the cumulative proportion

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# 1988

p224r63_1988_res<- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)

plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model) # also high correlation among the different bands
#99.56% by PC1

pairs(p224r63_1988)

#difference

difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map

plot(difpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100) #

plot(difpca$PC1,col=cldif)

################################################
################################################

# R_code_point_pattern_analysis.r
# Density map

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

#####################################################
#####################################################

# R_code_radiance.r

library(raster)

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2) #2columns 2 rows 2by2 raster

values(toy) <- c(1.13,1.44,1.55,3.4)

plot(toy)

text(toy, digits=2)

# Lets try with 2 bits

toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[]) = "integer"     ### to ensure we use integer values and not floating values (e.g. don't want 2.5 value) 

plot(toy2bits)
text(toy2bits, digits=2)

# Lets try with 4 bits

toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"

plot(toy4bits)
text(toy4bits, digits=2)

# Lets do 8 bits, 256 potential values!
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"

plot(toy8bits)
text(toy8bits, digits=2)

# Plot altogether!

par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2) 

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)

#####################################################
#####################################################

#R_code_sdm.r
# Species Distribution Modelling


# install.packages("sdm")
# install.packages("rgdal") # used to import vector layers
# install.packages("rgdal, dependencies=T") if theres a problem

library(sdm)
library(raster) # predictors: ecological variables, main environmental variable
library(rgdal) # species Geospatial Data Abstraction Library

# species
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)

species
# using utm and data from spain

species$occurence
# 0 = no species, 1= species

plot(species) 

plot(species[species$Occurrence == 1,],col='blue',pch=16) # '==' means only values of 1  #blue species presence

points(species[species$Occurrence == 0,],col='red',pch=16) # adds red points that represent the absent species


## Predictors

path <- system.file("external", package="sdm") 

lst <- list.files(path=path,pattern='asc$',full.names = T) # pattern is asc files, similar to jpeg
lst

preds <- stack(lst) # stack of four files


cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# 
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16) # adding points of where species are present

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# the higher the temperature, the high presence of species

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# sp. loves medium precipitation

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# sp. likes medium vegetation


#### Lets put all this info together and make a model!

d <- sdmData(train=species, predictors=preds) # training data= insitu data, predictors= stack of all predictors
d

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') # '~' means equal in a model, data=d which means dataset with sdm function we did above 
p1 <- predict(m1, newdata=preds) # making new data from predictors

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

s1<- stack(preds, p1) # stack of all variables
plot(s1, col=cl)

#########################################
#########################################

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

#########################################
#########################################

# R_code_faPAR.r

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


###### regression model between faPAR and NDVI
erosion<- c(12,14,16,24,26,40,55,67)
hm<- c(30, 100, 150,200, 260, 340, 460, 600)  #hm=heavy metals and its in ppm

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")


model1 <- lm(hm ~ erosion)
abline(model1)

setwd("~/lab/")

faPAR10 <- raster("~/lab/faPAR10.tif")

library(raster)
faPAR10 <- raster("~/lab/faPAR10.tif")
library(rasterdiv)
 


copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)
library(sf) # to call st_* functions
random.points <- function(x,n)

pts <- random.points(faPAR10,1000)

pts <- random.points(faPAR10,1000)
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

copNDVIp <- extract(copNDVI, pts)

model2 <- lm(faPAR10p ~ copNDVIp)

plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")

#####################################################
#####################################################

# R_code_ecosystem_functions.r

# R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
#proxies to measure these two parameters (plants)

install.packages("rasterdiv") 

library(rasterVis)
library(rasterdiv)

data(copNDVI)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)
 
copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)


###########################################

setwd("/Users/roxanechenmintao/lab")

library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

#defor1
# band1:NIR, defor1_.1
# band2: red, defor1_.2
# band3: greeb

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2

#defor2
# band1: NIR, defor2_.1
# band2: red, defor2_.2

dvi2 <- defor2$defor2_.1 - defor1$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi)

plot(difdvi, col=cld)

hist(difdvi)

#####################################################
#####################################################

# R_code_crop.r 

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

#####################################################
#####################################################

# R_code_Interpolation.r
## canopy cover

setwd("Users/roxanechenmintao/lab")

install.packages("spatstat")
library(spatstat)

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)
attach(inp)
plot(X,Y)

summary(inp)
 
inppp<- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))
marks(inppp)<- Canopy.cov

canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green")

marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

# output <- stack(canopy,lichs)
# plot(lichs)


par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

 
 # Psamophilous vegetation
 
 inp.psam <- read.table("dati psmamophile.csv.php", sep=";", head=T)
 attach(inp.psam)
 head(inp.psam)
 
 dev.off()
 
 plot(E, N) # east and north
 summary(inp.psam)
 
 inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
 marks(inp.psam.ppp) <- C_org
 
C <- Smooth(inp.psam.ppp) 

plot(C)
points(inp.psam.ppp)


#####################################################
#####################################################

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

##############################################
##############################################

#R_code_project.r

setwd("/Users/roxanechenmintao/lab/albedo/")
library(raster)
library(ncdf4)
library(rgdal)
albedo2016<-raster("c_gls_ALDH_QL_201601240000_GLOBE_PROBAV_V1.5.1.tiff")
albedo2017<-raster("c_gls_ALDH_QL_201701240000_GLOBE_PROBAV_V1.5.1.tiff")
albedo2018<-raster("c_gls_ALDH_QL_201801240000_GLOBE_PROBAV_V1.5.1.tiff")
albedo2019<-raster("c_gls_ALDH_QL_201901240000_GLOBE_PROBAV_V1.5.1.tiff")
albedo2020<-raster("c_gls_ALDH_QL_202001240000_GLOBE_PROBAV_V1.5.1.tiff")
par(mfrow=c(2,3))
cl<-colorRampPalette(c("dark green","green","beige", "orange", "yellow"))(100)
plot(albedo2016, col=cl)
plot(albedo2017, col=cl)
plot(albedo2018, col=cl)
plot(albedo2019, col=cl)
plot(albedo2020, col=cl)
ALBEDO2016<-plot(albedo2016, col=cl, main="Albedo 2016")
ALBEDO2017<-plot(albedo2017, col=cl, main="Albedo 2017")
ALBEDO2018<-plot(albedo2018, col=cl, main="Albedo 2018")
ALBEDO2019<-plot(albedo2019, col=cl, main="Albedo 2019")
ALBEDO2020<-plot(albedo2020, col=cl, main="Albedo 2020")


albedolist<-list.files(pattern="c_gls_ALDH_QL")
albedolist
import<-lapply(albedolist, raster)
albedo.multitemp<-stack(import)
plot(albedo.multitemp, col=cl)

albedo.multitemp
ext<-c(-180, 180, -90, 90) 
extension<-crop(albedo.multitemp,ext)
time<-1:nlayers(albedo.multitemp)
fun<-function(x) { if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 

predicted.albedo.2021<-calc(extension, fun)
plot(predicted.albedo.2021, col=cl)
final.stack<-stack(albedo.multitemp, predicted.albedo.2021)
plot(final.stack, col=cl)
png("final_plot_albedo.png")
plot(final.stack, col=cl)
dev.off()



### too cool for school ###

