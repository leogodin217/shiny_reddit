
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Shiny Reddit"),
  sidebarPanel(
    textInput("subreddit_name", "Which subreddit do you want to analyze", "patriots"),
    submitButton("Analyze Subreddit")
  ),

  mainPanel(
    textOutput("subreddit_url"),
    textOutput("valid_subreddit"),
    conditionalPanel(
      condition = "output.valid_subreddit == 0",
      h2("Not a valid subreddit")
    ),
    conditionalPanel(
      condition = "output.valid_subreddit == 1",
      h2("Valid subreddit")
    )
  )
))
