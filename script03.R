#' Section 03: Display map interactively.
#' @author Gonzales Andrea

library(rgee)
library(cptcity)

ee_Initialize()

# --------------------------------------------------------------
# 1. Load the SRTM ee$Image
# --------------------------------------------------------------
dem <- ee$Image$Dataset$CGIAR_SRTM90_V4


# --------------------------------------------------------------
# 2. Define the visualization parameters
# --------------------------------------------------------------
viz <- list(
  min = 600,
  max = 6000,
  palette = cpt(pal = 'grass_elevation', rev = TRUE)
)


# --------------------------------------------------------------
# 3. Create a simple interactive map!
# --------------------------------------------------------------
m1 <- Map$addLayer(dem, visParams = viz, name = "SRTM", shown = TRUE)
m1


# --------------------------------------------------------------
# 4. (OPTIONAL) Add a custom legend to the map
# --------------------------------------------------------------
pal <- Map$addLegend(viz)
m1 + pal


# --------------------------------------------------------------
# 5. Create an interactive map for ee$Geometry objects
# --------------------------------------------------------------
vector <- ee$Geometry$Point(-77.011,-11.98) %>%
  ee$Feature$buffer(50*1000)
Map$centerObject(vector)
Map$addLayer(vector) # eeObject is a ee$Geometry$Polygon.


# --------------------------------------------------------------
# 6. Create an interactive map for ee$FeatureCollection objects
# --------------------------------------------------------------
building <- ee$FeatureCollection$Dataset$
  `GOOGLE_Research_open-buildings_v1_polygon`
Map$setCenter(3.389, 6.492, 17)
Map$addLayer(building) # eeObject is a ee$FeatureCollection


# --------------------------------------------------------------
# 7. Create an interactive map for ee$ImageCollection objects
# --------------------------------------------------------------
etp <- ee$ImageCollection$Dataset$MODIS_NTSG_MOD16A2_105 %>%
  ee$ImageCollection$select("ET") %>%
  ee$ImageCollection$filterDate('2014-04-01', '2014-06-01')

viz <- list(
  min = 0,  max = 300,
  palette = cpt(pal = "grass_bcyr", rev = TRUE)
)

Map$setCenter(0, 0, 1)
etpmap <- Map$addLayers(etp, visParams = viz)
etpmap


# --------------------------------------------------------------
# 8. Compare two maps using | operator
# --------------------------------------------------------------
landsat <- ee$Image('LANDSAT/LT04/C01/T1/LT04_008067_19890917')
ndsi <- landsat$normalizedDifference(c('B3', 'B5'))
ndsiMasked <- ndsi$updateMask(ndsi$gte(0.4))

vizParams <- list(
  bands <- c('B5', 'B4', 'B3'), # vector of three bands (R, G, B).
  min = 40,
  max = 240,
  gamma = c(0.95, 1.1, 1) # Gamma correction factor.
)

ndsiViz <- list(
  min = 0.5,
  max = 1,
  palette = c('00FFFF', '0000FF')
)

Map$setCenter(lon = -77.20, lat = -9.85, zoom = 10)

m2 <- Map$addLayer(ndsiMasked, ndsiViz, 'NDSI masked')
m1 <- Map$addLayer(landsat, vizParams, 'false color composite')
m2  | m1
