# Load required libraries
library(tidyverse)
library(ggradar)
library(targets)
library(tarchetypes)
library(quarto)
source("R/Functions.R")

# Define the pipeline
list(
  # Load the dataset
  tar_target(fires, get_data()),

  # Transform the dataset by reordering months and days
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

  # Generate a bar plot of fire occurrences by month
  tar_target(
    fires_by_month_plot,
    plot_fires(forest_fires, month, "Month")),

  # Generate a bar plot of fire occurrences by day
  tar_target(
    fires_by_day_plot,
    plot_fires(forest_fires, day, "Day")),

  # Convert data to long format for further visualization
  tar_target(forest_fires_long,
             forest_long(forest_fires)),

  # Create a boxplot to show monthly variation of variables
  tar_target(forest_fires_long_boxplot,
             plot_boxplot(forest_fires_long)),

  # Generate scatter plots showing relationships between variables
  tar_target(forest_fires_pointplot,
             plot_pointplot(forest_fires_long)),

  # Create a heatmap showing fire frequency by month and day
  tar_target(fires_heatmap,
             plot_heatmap(forest_fires)),

  # Generate a scatter plot showing the effect of wind and rain on burned area
  tar_target(scatter_wind_area_plot,
             plot_scatter_wind_area(forest_fires)),

  # Create a radar chart to summarize monthly fire weather parameters
  tar_target(radar_chart_plot,
             plot_radar_chart(forest_fires))

  # Optionally render a Quarto document
  #tar_quarto(
  #  my_doc,
  #  path = "my_doc.qmd"
  #)

  )
