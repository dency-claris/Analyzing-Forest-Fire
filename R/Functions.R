# Function to read the forest fire dataset
get_data <- function(){
  readr::read_csv("forestfires.csv")
}

# Function to transform the dataset
# Reorders the 'month' and 'day' columns based on predefined orders
transform_data <- function(data, month_order, day_order){
  data |>
    mutate(
      month = factor(month, levels = month_order),
      day = factor(day, levels = day_order)
    ) |>
    select(everything())
}

# Function to plot the number of fires by a specified column
plot_fires <- function(data, level_col, level_label){
  fires <- data |>
    group_by({{ level_col }})|>
    summarize(total_fires = n(), .groups = "drop")
  fires |>
    ggplot(aes(x = {{ level_col }}, y = total_fires, fill = "Fire Count")) +
    geom_col() +
    theme (
      plot.title = element_text(size=15, face= "bold", colour= "black" ),
      axis.title.x = element_text(size=14, face="bold", colour = "black"),
      axis.title.y = element_text(size=14, face="bold", colour = "black"),
      axis.text.x = element_text(size=12, face="bold", colour = "black"),
      axis.text.y = element_text(size=12, face="bold", colour = "black")
    ) +
    labs(
      title = paste("Number of forest fires by", level_label),
      y = "Fire count",
      x = level_label
      )
}

# Function to convert dataset to long format for easier visualization
forest_long <- function(data){
  forest_fires_long <- data |>
    pivot_longer(
      cols = c("FFMC", "DMC", "DC",
               "ISI", "temp", "RH",
               "wind", "rain"),
      names_to = "data_col",
      values_to = "value"
    )
}

# Function to create boxplots for monthly variation of variables
plot_boxplot <- function(data) {
  data %>%
    ggplot(aes(x = month, y = value, fill = month)) +
    geom_boxplot(outlier.color = "red", outlier.size = 2, alpha = 0.7) +
    facet_wrap(vars(data_col), scales = "free_y", ncol = 2) +
    scale_fill_brewer(palette = "Set3") +
    theme_minimal(base_size = 14) +
    theme(
      panel.grid.major = element_line(color = "gray80", linewidth = 0.5),
      strip.background = element_rect(fill = "lightblue", color = NA),
      legend.position = "none"
    ) +
    labs(
      title = "Monthly Variation of Variables",
      subtitle = "Boxplots showing the distribution of variables over months",
      x = "Month",
      y = "Variable Value"
    )
}

# Function to create scatter plots showing relationships with burned area
plot_pointplot <- function(data) {
  data %>%
    filter(area < 300) %>%  # Filter area < 300
    ggplot(aes(x = value, y = area, color = data_col)) +  # Use color for 'data_col'
    geom_point(size = 3, alpha = 0.7) +  # Add transparency for better visibility
    geom_smooth(method = "lm", se = FALSE, linetype = "dashed", color = "black") +  # Add trend lines
    facet_wrap(vars(data_col), scales = "free_x", ncol = 2) +  # Free scales and two columns
    scale_color_brewer(palette = "Dark2") +  # Use a distinct color palette
    theme_minimal(base_size = 14) +  # Clean theme with larger text
    theme(
      panel.grid.major = element_line(color = "gray80", linewidth = 0.5),  # Light grid lines
      strip.background = element_rect(fill = "lightblue", color = NA),  # Background for facet strips
      legend.position = "bottom"  # Move legend to bottom
    ) +
    labs(
      title = "Variable Relationships with Burned Area",
      subtitle = "Scatter plots showing relationships (area < 300)",
      x = "Value of Column",
      y = "Burned Area (Hectares)",
      color = "Variable"
    )
}

# Function to save plots to a specified path
save_plot <- function(save_path, plot){
  ggsave(save_path, plot)
  save_path
}

# Function to create a heatmap of fire frequency by month and day
plot_heatmap <- function(data) {
  data |>
    count(month, day) |>
    ggplot(aes(x = month, y = day, fill = n)) +
    geom_tile(color = "white") +
    scale_fill_viridis_c(option = "C", direction = -1, name = "Fire Count") +
    labs(
      title = "Forest Fires Frequency Heatmap by Month and Day",
      x = "Month",
      y = "Day"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      panel.grid = element_blank()
    )
}

# Function to plot scatterplots of wind, rain, and area burned
plot_scatter_wind_area <- function(data) {
  data |>
    ggplot(aes(x = wind, y = area, size = rain, color = temp)) +
    geom_point(alpha = 0.7) +
    scale_color_viridis_c(option = "B", name = "Temperature (°C)") +
    scale_size_continuous(name = "Rain (mm/m²)", range = c(2, 10)) +
    labs(
      title = "Impact of Wind Speed and Rain on Burned Area",
      x = "Wind Speed (km/h)",
      y = "Area Burned (ha)"
    ) +
    theme_minimal() +
    theme(
      legend.position = "right",
      plot.title = element_text(size = 14, face = "bold")
    )
}

# Function to create a radar chart of monthly fire weather parameters
plot_radar_chart <- function(data) {
  # Summarize data by month
  plot_data <- data |>
    group_by(month) |>
    summarize(
      FFMC = mean(FFMC, na.rm = TRUE),
      DMC = mean(DMC, na.rm = TRUE),
      DC = mean(DC, na.rm = TRUE),
      ISI = mean(ISI, na.rm = TRUE)
    )

  # Ensure numeric data
  plot_data <- plot_data |>
    mutate_if(is.factor, as.numeric)

  # Set grid.max dynamically
  grid_max_value <- max(plot_data[-1], na.rm = TRUE)

  # Plot radar chart
  ggradar(
    plot_data,
    grid.min = 0,
    grid.mid = grid_max_value / 2,
    grid.max = grid_max_value
  ) +
    labs(title = "Radar Chart of Monthly Fire Weather Parameters")
}
