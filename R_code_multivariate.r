# R code for multivariate analysis

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
