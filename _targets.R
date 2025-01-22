library(tidyverse)
library(targets)
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

  tar_target(
    fires_by_month_plot_saved,
    save_plot("fig/fires_by_month.png", fires_by_month_plot),
    format = "file"),

  tar_target(
    fires_by_day_plot_saved,
    save_plot("fig/fires_by_day.png", fires_by_day_plot),
    format = "file"),

  tar_target(
    forest_fires_boxplot_saved,
    save_plot("fig/forest_fires_boxplot.png", forest_fires_long_boxplot),
    format = "file"),

  tar_target(
    forest_fires_pointplot_saved,
    save_plot("fig/forest_fires_pointplot.png", forest_fires_pointplot),
    format = "file")

  )
