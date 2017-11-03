links_pagina <- function(sessao = html_session('http://www.valor.com.br'), css = '.teaser-title a') {
  sessao %>% read_html() %>% html_nodes(css) %>% html_attr('href') %>%
    magrittr::extract(. != '') %>%
    ifelse(test = grepl(pattern = '\\bhttp', x = .), no = paste0('http://www.valor.com.br', .))
}
