
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rjson)
library(rCharts)
library(ggplot2)

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

 # Turn the json object into a dataframe of articles
  articles = reactive({
   if(valid_subreddit(subreddit())){
     # Loop throught the subreddit children(Articles) and pull data
     children = subreddit()[[2]]$children
     titles       = c()
     ups          = c()
     num_comments = c()
     
     for(child in children) {
       titles       = append(titles, child$data$title)
       ups          = append(ups, child$data$ups)
       num_comments = append(num_comments, child$data$num_comments)
     }
     
     # Combine them
     article_data = data.frame(titles, ups, num_comments)
   }
   return(article_data)
 }) 
  
 
  # Figure out the correlation
  output$correlation = renderTable({
    correlation  = cor(articles()$ups, articles()$num_comments)
    num_comments = sum(articles()$num_comments)
    upvotes      = sum(articles()$ups)
    fields       = c("Comments", "Upvotes", "Correlation")
    df           = data.frame(fields, c(num_comments, upvotes, correlation))
    names(df)    = c("Field", "Value")
    return(df)
  })
 
  # Plot comments vs upvotes
  output$correlation_chart = renderPlot({
    ggplot(articles(), aes(x=ups, y=num_comments)) +
      geom_point() +
      ggtitle("Upvotes vs Comments") +
      xlab("Upvotes") + 
      ylab("Comments")
  })
  
})
