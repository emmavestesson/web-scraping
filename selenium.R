library(RSelenium)
'https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/'

covid_reports <- 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports'
rD <- rsDriver(port = 9515L)
remDr <- rD$client
remDr$navigate(covid_reports)



webElem <- remDr$findElement(using = "css", "[class = 'more-button']")
webElem$clickElement()
html <- remDr$getPageSource()[[1]]

write.table(html, 'selenium.txt')
html_selenium <- read_html(html)

saveRDS(html_selenium, 'html_selenium.rds')
save_html(html_selenium, 'html_selenium.rds')
html_rvest <- covid_reports %>% 
  bow() %>% 
  scrape()

html_rvest %>% 
  html_elements("strong") %>% 
  html_attr('href') 

html_rvest %>% 
  html_elements('body') %>% 
  html_children() %>% 
  html_name()

html_rvest %>% 
  # html_elements('body') %>% 
  html_elements('h3')

html_selenium %>% 
  html_elements('div.sf') %>% 
  html_children() %>% 
  html_children() %>% 
  html_name()

list_of_direct_urls <- html_selenium %>% 
  html_elements('.more-content-inner') %>% 
  # html_children() %>% 
  # html_children() %>%
  html_elements('a') %>% 
  html_attr('href') 

# remove unnessary links
url_df <- tibble::tibble(url= list_of_direct_urls) %>% 
  dplyr::filter(stringr::str_starts(string = url, '/docs')) %>% 
  dplyr::mutate(file_name = path_file(url), 
                file_name = path_ext_remove(file_name), 
                file_name = paste0(file_name, '.pdf'), 
                url_full = paste0('www.who.int', url))
url_df %>% 
  distinct(file_name, url_full)
mini <- url_df[1:3,] %>% 
  distinct(file_name, url_full)

map2(mini$url_full, mini$file_name, 
     ~curl_download(.x, .y))

html_rvest %>% 
  html_elements('.more-content-inner') %>% 
  # html_children() %>%
  html_elements('a') %>% 
  html_attr('href') 

curl::curl_download('who.int/docs/default-source/coronaviruse/situation-reports/20200121-sitrep-1-2019-ncov.pdf?sfvrsn=20a99c10_4', destfile = 'win.pdf')
