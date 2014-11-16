library(rjson)

subreddit_url = "http://reddit.com/r/patriots.json"


subreddit = fromJSON(file=subreddit_url)
articles = subreddit[[2]]$children

