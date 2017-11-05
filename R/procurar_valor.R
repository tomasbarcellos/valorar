#' Procurar noticias no site do jornal Valor Economico
#'
#' @importFrom utils getFromNamespace
#' @importFrom stringr str_extract
#' @importFrom magrittr extract2
#'
#' @param termo Termo buscado
#' @param sessao Sessao
#' @param paginas numero de paginas que serao retornadas
#'
#' @return Uma sessao com resultados da busca
#' @export
#'
#' @examples
#' \dontrun{
#' procurar_valor('desemprego')
#' }
#'
procurar_valor <- function(termo, #sessao = rvest::html_session('http://www.valor.com.br'),
                           paginas = 5) {
  requireNamespace('wdman', quietly = TRUE)
  requireNamespace('binman', quietly = TRUE)

  renderizar_ler <- function(url) {
    tf <- tempfile(fileext = '.html')
    JS <- system.file('js','phantom.js', package = 'valorar')

    system(paste(phantomJS()$path, JS, url, tf), intern = TRUE)

    read_html(tf)
  }

  url <- paste0('http://www.valor.com.br/busca/', termo)
  html <- renderizar_ler(url)
  links <- html %>% html_nodes('.title2 a') %>% html_attr('href')
  resultados <- html %>% html_nodes('.search-result-term') %>% html_text() %>%
    magrittr::extract2(1) %>%
    gsub(pattern = '\t', replacement = '') %>%
    stringr::str_extract('de [0-9]+') %>%
    gsub(pattern = 'de *', replacement = '') %>%
    as.numeric()

  # if (paginas != 1) {
  #   paginacao <- paste0(url, '?page=', seq_len(resultados/10), '&method=ajax')
  #   links2 <- purrr::map_chr(paginacao[seq_len(paginas)][-1],
  #                            ~ renderizar_ler(.x) %>% links_pagina('.title2 a'))
  #   links <- c(links, links2)
  # }

  # attr(sessao, 'pagina') <- 1
  # attr(sessao, 'resultados') <- resultados
  # attr(sessao, 'links') <- links
  # sessao

  links
}








