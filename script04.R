#' Section 04: Display map interactively.
#' @author Antony Barja, Gonzales Andrea and Fernando Herrera

library(rgee)
library(reticulate)

ee_Initialize()

# --------------------------------------------------------------
# 1. Install and load a Python package
# --------------------------------------------------------------
py_install("ndvi2gif")
ngif <- import("ndvi2gif")


# --------------------------------------------------------------
# 2. Define your study area
# --------------------------------------------------------------
colca <- c(-73.15315, -16.46289, -73.07465, -16.37857)
roi <- ee$Geometry$Rectangle(colca)
Map$centerObject(roi)
Map$addLayer(roi)

# --------------------------------------------------------------
# 3. Create a NdviSeasonality object ---> py_help(ngif$NdviSeasonality)
# Class to generate NDVI seasonal compositions gifs. The output is an ee.Image
# with 4 bands, one band per season. Color combination will show phenology over
# the seasons and over the years. In ndvi2gif the season are defined as follow:
# winter = c('-01-01', '-03-31')
# spring = c('-04-01', '-06-30')
# summer = c('-07-01', '-09-30')
# autumn = c('-10-01', '-12-31')
# The main method available are:
# - get_export: Export NDVI year compositions as .tif to your local folder. This
#               method calls geemap.ee_export_image.
# - get_export_single: Export single composition as .tif to your local folder
# - get_year_composite: Return the composite ndvi for each year
# - get_gif: Export NDVI year compositions as .gif to your local folder
# --------------------------------------------------------------
myclass <- ngif$NdviSeasonality(
  roi = roi,
  start_year = 2016L,
  end_year = 2020L,
  sat = 'Sentinel', # 'Sentinel', 'Landsat', 'MODIS', 'sar'
  key = 'max' # 'max', 'median', 'perc_90'
)

# Estimate the median of the yearly composites from 2016 to 2020.
median <- myclass$get_year_composite()$median()

# Estimate the median of the winter season composites from 2016 to 2020.
wintermax <- myclass$get_year_composite()$select('winter')$max()

# --------------------------------------------------------------
# 8. Compare results using | operator
# --------------------------------------------------------------
Map$addLayer(wintermax, list(min = 0.1, max = 0.8), 'winterMax') |
  Map$addLayer(median, list(min = 0.1, max = 0.8), 'median')

# --------------------------------------------------------------
# 9. Export results as a GIF format
# --------------------------------------------------------------
myclass$get_gif()
