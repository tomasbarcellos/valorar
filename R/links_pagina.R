
#' Pega noticias da sessao
#'
#' @param sessao Uma sessao criada por \code{\link{html_session}}
#'
#' @return Uma string com os links da pagina no css
#' @importFrom rvest html_nodes html_attr
#' @importFrom magrittr %>% extract
#' @export
#'
#' @examples
#' html_session("http://www.valor.com.br") %>% links_pagina()
links_pagina <- function(sessao) {
  css <- '.teaser-title a'
  links <- sessao %>% rvest::html_nodes(css) %>%
    rvest::html_attr('href') %>%
    eliminar_vazios()

  ifelse(grepl(pattern = '^http', x = links), links,
         no = paste0('http://www.valor.com.br', links))
}

#' Title
#'
#' @param x vetor de caracteres
#'
#' @return o mesmo vetor sem os elementos vazios ("")
eliminar_vazios <- function(x) {
  x[x != ""]
}
