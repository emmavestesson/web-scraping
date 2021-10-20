bow('https://eurovisionworld.com/eurovision') %>% 
  scrape() %>% 
  html_nodes('table') %>%
  # html_table()
  html_attrs()
  html_structure() 

reddit <-  'https://www.reddit.com/' 

rD <- rsDriver(port = 9515L)
remDr <- rD$client
remDr$navigate(reddit)
remDr$getActiveElement()
remDr$getWindowHandles()
remDr$sendKeysToActiveElement(list(key = "page_down"))

remDr$sendKeysToActiveElement(list(key = "end"))

base <- remDr$getPageSource()[[1]]

base2 <- remDr$getPageSource()[[1]]

remDr$close()
