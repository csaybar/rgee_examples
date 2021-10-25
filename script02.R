#' Section 02: Create a 3D population density map with rgee and rayshader.
#' @author Antony Barja and Fernando Herrera

library(rayshader)
library(raster)
library(rgee)


# --------------------------------------------------------------
# 1. Initialize Earth Engine and Google Drive, both
# credentials must come from the same account google account.
# --------------------------------------------------------------
ee_Initialize(user="ndef", drive = TRUE)


# --------------------------------------------------------------
# 2. Load the WorldPop Global Project Population Dataset
# --------------------------------------------------------------
collections <- ee$ImageCollection$Dataset
population_data <- collections$CIESIN_GPWv411_GPW_Population_Density
population_data_max <- population_data$max()


# --------------------------------------------------------------
# 3. (OPTIONAL) Use ee_utils_dataset_display to display
# the official documentation in the Earth Engine Catalog.
# --------------------------------------------------------------
population_data %>% ee_utils_dataset_display()


# --------------------------------------------------------------
# 4. Download the population density for South America
# --------------------------------------------------------------
sa_extent <- ee$Geometry$Rectangle(
  coords = c(-100, -50, -20, 12),
  geodesic = TRUE,
  proj = "EPSG:4326"
)

population_data_ly_local <- ee_as_raster(
  image = population_data_max,
  region = sa_extent,
  dsn = "/home/pc-user01/population.tif", # change for your own path.
  scale = 5000
)


# --------------------------------------------------------------
# 5. Convert the RasterObject into a matrix.
# --------------------------------------------------------------
pop_matrix <- raster_to_matrix(population_data_ly_local)


# --------------------------------------------------------------
# 6. Modify the matrix using built-in rayshader functions
# --------------------------------------------------------------
pop_matrix %>%
  sphere_shade(
    texture = create_texture("#FFFFFF", "#0800F0", "#FFFFFF", "#FFFFFF", "#FFFFFF")
  ) %>%
  plot_3d(
    elmat,
    zoom = 0.55, theta = 0, zscale = 100, soliddepth = -24,
    solidcolor = "#525252", shadowdepth = -40, shadowcolor = "black",
    shadowwidth = 25, windowsize = c(800, 720)
  )

# --------------------------------------------------------------
# 7. Export the final results
# --------------------------------------------------------------
text <- paste0(
  "South America\npopulation density",
  strrep("\n", 27),
  "Source:GPWv411: Population Density (Gridded Population of the World Version 4.11)"
)

render_snapshot(
  filename = "30_poblacionsudamerica.png",
  title_text = text,
  title_size = 20,
  title_color = "black",
  title_font = "Roboto bold",
  clear = TRUE
)
