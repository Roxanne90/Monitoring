# R_code_exam.r
# 1.  R_code_first.r
# 2.  R_code_spatial.r
# 3.  R_code_Multipanel.r
# 4.  R_code_Multivariate.r 
# 5.  R_code_remote_sensing.r
# 6.  R_code_rs.r
# 7. R_code_no2.r

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

