library(tidyverse)
library(targets)
cat("The 'targets' package has been successfully loaded.\n")


source("Functions.R")
data("forest_fires")

# Make sure you ran tar_make() so forest_fires is available in your _targets/ cache
forest_fires <- tar_read(forest_fires)


enableBookmarking(store = "url")
