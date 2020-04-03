# R code for spatial view of points

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
bubble(meuse, "zinc", main="Zinc cocnentration")

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



