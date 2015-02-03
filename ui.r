library(shiny)
library(dplyr)
library(ggvis)

shinyUI(bootstrapPage(

  titlePanel("Předvolební průzkumy"), 
  sidebarPanel(uiOutput("p_ui")),
  mainPanel(
      ggvisOutput("plot1")
  )
))
