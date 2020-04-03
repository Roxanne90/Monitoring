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

