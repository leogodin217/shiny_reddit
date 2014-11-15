
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  subreddit_url = reactive(paste("http://reddit.com/r/", input$subreddit_name, ".json", sep="")) 
  output$subreddit_url = renderText(subreddit_url())

 valid_subreddit = function(subreddit) {
   # If no children, then it's not a valid subreddit
   ifelse(length(subreddit()[[2]]$children) == 0, FALSE, TRUE) 
 }

 # Get the data and make sure it's valid
 subreddit = reactive(fromJSON(file=subreddit_url()))
 output$valid_subreddit = reactive(valid_subreddit(subreddit))
 
 
})
