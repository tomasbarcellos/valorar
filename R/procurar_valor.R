#' Procurar noticias no site do jornal Valor Economico
#'
#' @importFrom stringr str_extract
#' @importFrom magrittr extract2
#'
#' @param sessao Sessao
#' @param termo Termo buscado
#' @param paginas numero de paginas que serao retornadas
#'
#' @return Um vetor com os links das noticias encontradas
#' @export
#'
#' @examples
#' \dontrun{
#' procurar_valor('desemprego')
#' }
#'
procurar_valor <- function(sessao, termo, paginas = 5) {
  if (methods::is(sessao) != "Session") {
    stop("`sessao` deve ser um objeto gerado com 'webdriver::Session$new()'",
         call. = FALSE)
  }

  url <- paste0('http://www.valor.com.br/busca/', termo)

  pegar_links <- function(url) {
    sessao$go(url)
    html <- sessao$getSource() %>% read_html()
    html %>% html_nodes('.title2 a') %>% html_attr('href')
  }

  # links <- pegar_links(url)
  sessao$go(url)
  html <- sessao$getSource() %>% read_html()

  resultados <- html %>% html_nodes('.search-result-term') %>% html_text() %>%
    magrittr::extract2(1) %>%
    gsub(pattern = '\t', replacement = '') %>%
    stringr::str_extract('de [0-9]+') %>%
    gsub(pattern = 'de *', replacement = '') %>%
    as.numeric()

  links <- html %>% html_nodes('.title2 a') %>% html_attr('href')

  if (paginas != 1 & resultados > 10) {
    paginacao <- paste0(url, '?page=', seq_len( (resultados/10) + 1))
    links2 <- purrr::map(paginacao[seq_len(paginas)[-1]], pegar_links) %>%
      unlist()
    links <- c(links, links2)
  }

  links
}

