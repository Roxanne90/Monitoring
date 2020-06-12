#### R_code_Interpolation.r
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



 



 
