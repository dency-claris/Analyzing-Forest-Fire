ui <- fluidPage(
  titlePanel("Forest Fire Data Visualization"),

  sidebarLayout(
    sidebarPanel(
      # Drop-down to choose the plot type
      selectInput(
        "plotType", "Choose a Plot:",
        choices = c(
          "Fires by Month",
          "Fires by Day",
          "Boxplot of Variables",
          "Scatter: Wind vs Area",
          "Heatmap of Fires",
          "Radar Chart"
        )
      ),
      hr(),
      helpText("Original data from Kaggle")
    ),

    mainPanel(
      plotOutput("mainPlot")
    )
  )
)
