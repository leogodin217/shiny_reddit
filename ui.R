
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rCharts)

shinyUI(fluidPage(theme="bootstrap.css",

  # Application title
  titlePanel("Shiny Reddit"),
  sidebarPanel(
    textInput("subreddit_name", "Which subreddit do you want to analyze", "patriots"),
    submitButton("Analyze Subreddit"),
    p("Type in the name of a subreddit on http://reddit.com. This app will analyze the number of comments and upvotes on the subreddit's front page. Using this data, it will find the correlation between upvotes and comments, then plot data. If you don't know any subreddits, try typing common topics like motorcycles, news, art or cars. Chances are there is a subreddit")
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
      h4("This is a valid subreddit"),
      tableOutput("correlation"),
      plotOutput("correlation_chart")
    )
  )
))
