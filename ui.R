#Week4Assignment
library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict diamond price from carat"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "What is the carat of the diamond?", 0.1, 2.49, value = 1.5),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Diamond Price from Model 1 ($):"),
      textOutput("pred1"),
      h3("Predicted Diamond Price from Model 2 ($):"),
      textOutput("pred2")
    )
  )
))