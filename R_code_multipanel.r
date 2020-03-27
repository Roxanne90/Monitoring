### Multipanel in R: the second lecture of monitoring ecosystems

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
