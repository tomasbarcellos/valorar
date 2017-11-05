#' Pega noticias da sessao
#'
#' @param sessao Uma sessao criada por \code{\link{html_session}}
#' @param css Seletor de css que será passado para \code{\link{html_nodes}}
#'
#' @return Uma string com os links da pagina no css
#' @export
#'
#' @examples
#' links_pagina()
links_pagina <- function(html, css = '.teaser-title a') {
  if (missing(html)) html <- html_session('http://www.valor.com.br')
  html %>% html_nodes(css) %>% html_attr('href') %>%
    magrittr::extract(. != '') %>%
    ifelse(test = grepl(pattern = '\\bhttp', x = .),
           no = paste0('http://www.valor.com.br', .))
}
