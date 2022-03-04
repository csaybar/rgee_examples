#' Section 01: Installing rgee
#' This script has all the essentials to install all the rgee R and Python dependencies.
#' @author Angie Flores and Cesar Aybar

# The following R packages must be installed in order to go through the Practicum section.
install.packages('reticulate') # Connect Python with R.
install.packages('rayshader') # 2D and 3D data visualizations in R.
install.packages('remotes') # Install R packages from remote repositories.
remotes::install_github('r-earthengine/rgeeExtra') # rgee extended.
install.packages('sf') # Simple features in R.
install.packages('stars') # Spatiotemporal Arrays and Vector Data Cubes.
install.packages('geojsonio') # Convert data to 'GeoJSON' from various R classes.
install.packages('raster') # Reading, writing, manipulating, analyzing and modeling of spatial data.
install.packages('magick') # Advanced Graphics and Image-Processing in R
install.packages('leaflet.extras2') # Extra Functionality for leaflet
install.packages('cptcity') # colour gradients from the 'cpt-city' web archive


# --------------------------------------------------------------
# 1. Install rgee R dependencies
# If you find a bug/error following this guide reported in:
# https://github.com/r-spatial/rgee/issues/new
# --------------------------------------------------------------
install.packages("rgee")

# --------------------------------------------------------------
# 2.1 Install rgee Python dependencies - OPTION 01
# --------------------------------------------------------------
library(rgee)
ee_install() # Window user must need to terminate R and enter to R again.

# --------------------------------------------------------------
# 2.2 Load a Python ENV with the rgee requirements installed - OPTION 02
# --------------------------------------------------------------
# IMPORTANT: Change 'py_path' argument according to your own Python PATH. 
# Please choose just one option.

## For Anaconda users - Windows OS
win_py_path = paste0(
  "C:/Users/UNICORN/AppData/Local/Programs/Python/",
  "Python37/python.exe"
)
ee_install_set_pyenv(
  py_path = win_py_path,
  py_env = "rgee" # Change it for your own Python ENV
)

## For Miniconda users - Windows OS
win_py_path = paste0(
  "C:/Users/UNICORN/AppData/Local/r-miniconda/envs/rgee/",
  "python.exe"
)
ee_install_set_pyenv(
  py_path = win_py_path,
  py_env = "rgee" # Change it for your own Python ENV
)

## For Miniconda users - Linux/MacOS users
unix_py_path = paste0(
  "/home/UNICORN/.local/share/r-miniconda/envs/",
  "rgee/bin/python3"
)
ee_install_set_pyenv(
  py_path = unix_py_path,
  py_env = "rgee" # Change it for your own Python ENV
)

## For virtualenv users - Linux/MacOS users
ee_install_set_pyenv(
  py_path = "/home/UNICORN/.virtualenvs/rgee/bin/python",
  py_env = "rgee" # Change it for your own Python ENV
)

## For Python root user - Linux/MacOS users
ee_install_set_pyenv(
  py_path = "/usr/bin/python3",
  py_env = NULL, 
  Renviron = "global" # Save ENV variables in the global .Renv file
)

ee_install_set_pyenv(
  py_path = "/usr/bin/python3",
  py_env = NULL, 
  Renviron = "local" # Save ENV variables in a local .Renv file
)


# --------------------------------------------------------------
# 3. Check out whether your Python and R requirements are properly set up.
# --------------------------------------------------------------
ee_check()

# --------------------------------------------------------------
# 4. Authenticate and Initialize Earth Engine
# --------------------------------------------------------------

# Initialize just Earth Engine
ee_Initialize()

# Initialize Earth Engine and GD
ee_Initialize(drive = TRUE)

