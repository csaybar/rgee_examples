#' Section 01: Installing rgee
#' @author Angie Flores

# --------------------------------------------------------------
# 1. Install rgee R dependencies
# If you find a bug/error following this guide reported in:
# https://github.com/r-spatial/rgee/issues/new
# --------------------------------------------------------------
install.packages("rgee")

# --------------------------------------------------------------
# 2. Install rgee Python dependencies
# --------------------------------------------------------------
rgee::ee_install() # Window user must need to terminate R and enter to R again.

# --------------------------------------------------------------
# 3. Install a specific Earth Engine Python API version.
# --------------------------------------------------------------
ee_install_upgrade(version = "0.1.232")

# --------------------------------------------------------------
# 4. Load rgee and authenticate your EE acount
# --------------------------------------------------------------
library(rgee)
ee_Initialize()

# --------------------------------------------------------------
# 5. Helper function
# --------------------------------------------------------------
ee_help(ee$Algorithms$CannyEdgeDetector)
