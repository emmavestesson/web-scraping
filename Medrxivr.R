library(medrxivr)

preprint_data <- mx_snapshot()  

results_amr <- mx_search(data = preprint_data,
                     query ="AMR")

results_amr %>% 
  ggplot(., aes(y = category)) + geom_bar() + theme_minimal()

hi <- results_amr %>% 
  filter(category == 'Health Informatics')

mx_download(hi, 'amr_med', create = TRUE)
