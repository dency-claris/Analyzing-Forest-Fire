library(tidyverse)
library(targets)
library(tarchetypes)
library(quarto)
source("R/Functions.R")

list(
  tar_target(fires, get_data()),

  tar_target(
    forest_fires,
    transform_data(fires,
               month_order <- c("jan", "feb", "mar",
                                "apr", "may", "jun",
                                "jul", "aug", "sep",
                                "oct", "nov", "dec"),
               day_order <- c("sun", "mon", "tue", "wed", "thu", "fri", "sat")
               )
            ),

  tar_target(
    fires_by_month_plot,
    plot_fires(forest_fires, month, "Month")),

  tar_target(
    fires_by_day_plot,
    plot_fires(forest_fires, day, "Day")),

  tar_target(forest_fires_long, forest_long(forest_fires)),

  tar_target(forest_fires_long_boxplot,
             plot_boxplot(forest_fires_long)),

  tar_target(forest_fires_pointplot,
             plot_pointplot(forest_fires_long)),

  tar_quarto(
    my_doc,
    path = "my_doc.qmd"
  )

  )
