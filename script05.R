library(rgee)
library(rgeeExtra)

ee_Initialize()

# Load a Javascript module
LandsatLST <- module("users/sofiaermida/landsat_smw_lst:modules/Landsat_LST.js")

# Define Landsat_LST parameters
geometry <- ee$Geometry$Rectangle(c(-8.91, 40.0, -8.3, 40.4))
satellite <- 'L8'
date_start <- '2018-05-15'
date_end <- '2018-05-31'
use_ndvi <- TRUE

# Run the model
LandsatColl <- LandsatLST$collection(satellite, date_start, date_end, geometry, use_ndvi)
exImage <- LandsatColl$first()

# Create an interactive map
cmap <- c('blue', 'cyan', 'green', 'yellow', 'red')
lmod <- list(min = 290, max = 320, palette = cmap)
Map$centerObject(geometry)
Map$addLayer(exImage$select('LST'), lmod, 'LST')


