#' Section 01: Installing rgee
#' This script has all the essentials to install all the rgee R and Python dependencies.
#' @author Angie Flores and Cesar Aybar

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
# IMPORTANT: Change 'py_path' argument for your own Python PATH
ee_install_set_pyenv(
  py_path = "/home/pc-user01/.virtualenvs/rgee/bin/python",
  py_env = "rgee" # Change it for your own Python ENV
) 
# Window user must need to terminate R and enter to R again.
ee_check()

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

# Initialize Earth Engine and GCS
ee_Initialize(gcs = TRUE)

# Initialize Earth Engine, GD and GCS
ee_Initialize(drive = TRUE, gcs = TRUE)
