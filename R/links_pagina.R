#' Pega noticias da sessao
#'
#' @param sessao Uma sessao criada por \code{\link{html_session}}
#' @param css Seletor de css que será passado para \code{\link{html_nodes}}
#'
#' @return Uma string com os links da pagina no css
#' @export
#'
#' @examples
links_pagina <- function(sessao = html_session('http://www.valor.com.br'), css = '.teaser-title a') {
  sessao %>% read_html() %>% html_nodes(css) %>% html_attr('href') %>%
    magrittr::extract(. != '') %>%
    ifelse(test = grepl(pattern = '\\bhttp', x = .), no = paste0('http://www.valor.com.br', .))
}
