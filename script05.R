#' Section 04: Display map interactively.
#' @author Antony Barja, Cesar Aybar

library(rgee)
library(rgeeExtra)
library(reticulate)

ee_Initialize()

py_install(c("regex", "jsbeautifier")) 

# ------------------------------------------------------------------------------
# 1. Load a Javascript module
# ------------------------------------------------------------------------------
LandsatLST <- module("users/sofiaermida/landsat_smw_lst:modules/Landsat_LST.js")

# ------------------------------------------------------------------------------
# 2. Define Landsat_LST parameters
# ------------------------------------------------------------------------------
geometry <- ee$Geometry$Rectangle(c(-8.91, 40.0, -8.3, 40.4))
satellite <- 'L8'
date_start <- '2018-05-15'
date_end <- '2018-05-31'
use_ndvi <- TRUE

# ------------------------------------------------------------------------------
# 3. Run the model
# ------------------------------------------------------------------------------
LandsatColl <- LandsatLST$collection(
  landsat = satellite, 
  date_start = date_start, 
  date_end = date_end, 
  geometry = geometry, 
  use_ndvi = use_ndvi
)
exImage <- LandsatColl$first()

# ------------------------------------------------------------------------------
# 4. Create an interactive map
# ------------------------------------------------------------------------------
cmap <- c('blue', 'cyan', 'green', 'yellow', 'red')
lmod <- list(min = 290, max = 320, palette = cmap)
Map$centerObject(geometry)
Map$addLayer(exImage$select('LST'), lmod, 'LST')

