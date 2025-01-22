get_data <- function(){
  readr::read_csv("forestfires.csv")
}

clean_data <- function(data, month_order, day_order){
  data |>
    mutate(
      month = factor(month, levels = month_order),
      day = factor(day, levels = day_order)
    ) |>
    select(everything())
}

plot_fires <- function(data, level_col, level_label){
  fires <- data |>
    group_by({{ level_col }})|>
    summarize(total_fires = n(), .groups = "drop")
  fires |>
    ggplot(aes(x = {{ level_col }}, y = total_fires)) +
    geom_col() +
    labs(
      title = paste("Number of forest fires in data by", level_label),
      y = "Fire count",
      x = level_label
      )
}

forest_fires_long <- forest_fires %>%
  pivot_longer(
    cols = c("FFMC", "DMC", "DC",
             "ISI", "temp", "RH",
             "wind", "rain"),
    names_to = "data_col",
    values_to = "value"
  )

forest_fires_long %>%
  ggplot(aes(x = month, y = value)) +
  geom_boxplot() +
  facet_wrap(vars(data_col), scale = "free_y") +
  labs(
    title = "Variable changes over month",
    x = "Month",
    y = "Variable value"
  )
