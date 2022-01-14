# Make a few dimensions we can use
dimX <­ dim.def.ncdf( "Long", "degrees", Longvector )
dimY <­ dim.def.ncdf( "LAT", "degrees", Latvector )
dimT <­ dim.def.ncdf( "Time", "days", 1:18250, unlim=FALSE )
# Make varables of various dimensionality, for illustration purposes
mv <­ ­9999 # missing value to use
var1d <­ var.def.ncdf( "var1d", "units", dimX, mv,prec="double" )
var2d <­ var.def.ncdf( "var2d", "units", list(dimX,dimY), mv,prec="double" ) var3d <­ var.def.ncdf( "var3d", "units", list(dimX,dimY,dimT), mv,prec="double" )
# Create the test file
nc <­ create.ncdf( "writevals.nc", list(var1d,var2d,var3d) ) # !!Creates a nc file with + 4 Gb
# Adding the complete time series for one point (the first point in the list of the dataset) 
put.var.ncdf( nc, var3d,dataset[[1]], start=c(Longvector[1],Latvector[1],1), count=c(1,1,­1))
#Longvector and Latvector are vectors taken from the matrix with the Long and Lat for each point. The dataset is a list format and for each point I have a list of numeric values.
dataset[[1]]=c(0,0,0,9.7,0,7.5,3.6,2.9,0,0.5,....)
#Am I missing something or should I try other packages??
#improve this question edited May 17 '12 at 15:06 mdsumner
#asked May 13 '12 at 17:14
#A.R 554●4●21
#What are the lengths of Longvector and Latvector? Can you provide them, perhaps with a call to seq() or just dump code to recreate them with dput(). – mdsumner May 17 '12 at 5:54
#Please edit the question to include the missing information – mdsumner May 17 '12 at 6:08 1 Answer order by vote up 4
#vote down accepted
#There are some errors in your non­reproducible code, and by my reckoning the file is 219Mb (1500 * 18250 * 8 bytes).
library(ncdf)
#Provide the vectors for the first two dims and the dataset to match at least one slice
Longvector = seq(­180, 180, length = 50)
Latvector = seq(­90, 90, length = 30)
dataset <­ list(1:18250)
dimX <­ dim.def.ncdf("Long", "degrees", Longvector)
dimY <­ dim.def.ncdf("LAT", "degrees", Latvector)
dimT <­ dim.def.ncdf("Time", "days", 1:18250, unlim = FALSE)
mv <­ ­9999
var1d <­ var.def.ncdf( "var1d", "units", dimX, mv,prec="double")
var2d <­ var.def.ncdf( "var2d", "units", list(dimX,dimY), mv,prec="double") var3d <­ var.def.ncdf( "var3d", "units", list(dimX,dimY,dimT), mv,prec="double")
nc <­ create.ncdf( "writevals.nc", list(var1d,var2d,var3d))
#Count is the index of the dimension, not the axis position value, so we correct start to 1, and use the count (length) of the 3rd dimension (not ­1).
put.var.ncdf(nc, var3d, dataset[[1]], start = c(1, 1, 1), count = c(1, 1, length(dataset[[1]]))) close.ncdf(nc)