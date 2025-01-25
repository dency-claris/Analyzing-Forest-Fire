library(ggradar)


server <- function(session, input, output) {
  output$mainPlot <- renderPlot({
    # Generate the chosen plot based on user selection
    if (input$plotType == "Fires by Month") {
      plot_fires(forest_fires, month, "Month")

    } else if (input$plotType == "Fires by Day") {
      plot_fires(forest_fires, day, "Day")

    } else if (input$plotType == "Boxplot of Variables") {
      plot_boxplot(forest_fires_long)

    } else if (input$plotType == "Scatter: Wind vs Area") {
      plot_scatter_wind_area(forest_fires)

    } else if (input$plotType == "Heatmap of Fires") {
      plot_heatmap(forest_fires)

    } else if (input$plotType == "Radar Chart") {
      plot_radar_chart(forest_fires)
    }
  })
}
