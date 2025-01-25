library(tidyverse)
library(targets)
library(ggradar)

cat("The 'targets' package has been successfully loaded.\n")


source("R/Functions.R")
data("forest_fires")

# Make sure you ran tar_make() so forest_fires is available in your _targets/ cache
forest_fires <- tar_read(forest_fires)
forest_fires_long <- tar_read(forest_fires_long)

# Helper vectors for dropdowns
all_months <- sort(unique(forest_fires$month))
all_days <- sort(unique(forest_fires$day))

enableBookmarking(store = "url")
