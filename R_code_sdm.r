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






