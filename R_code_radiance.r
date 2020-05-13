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


