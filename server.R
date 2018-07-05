#Week4Assignment
#Load the required libraries
library(shiny)
library(UsingR)
library(dplyr)

shinyServer(function(input, output) {
  model1 <- lm(price ~ carat, data = diamonds)
  
  diamonds_filtered <- filter(diamonds, carat < 2.5)
  model2 <- lm(price ~ carat, data = diamonds_filtered)
  
  model1pred <- reactive({
    caratInput <- input$sliderCarat
    round(predict(model1, newdata = data.frame(carat = caratInput)), digits = 0)
  })
  
  model2pred <- reactive({
    caratInput <- input$sliderCarat
        round(predict(model2, newdata = data.frame(carat = caratInput)), digits = 0)
  })
  output$plot1 <- renderPlot({
    caratInput <- input$sliderCarat
    
    plot(diamonds$carat, diamonds$price, xlab = "Carat", 
         ylab = "Price ($)", bty = "n", pch = 16,
         xlim = c(0.1, 2.5), ylim = c(300, 20000))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      abline(model2, col = "blue", lwd = 2)
         }
    legend(0.1, 15000, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    if(input$showModel1){
      points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
    }
    if(input$showModel2){
      points(caratInput, model2pred(), col = "blue", pch = 16, cex = 2)
    }
  })
  
  output$pred1 <- renderText({
    if(input$showModel1){
      model1pred()
    }
  })
  
  output$pred2 <- renderText({
    if(input$showModel2){
      model2pred()
    }
  })
})