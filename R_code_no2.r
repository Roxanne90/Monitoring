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

