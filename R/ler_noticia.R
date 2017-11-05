#' Tira informacoes da noticia
#'
#' @importFrom tibble tibble
#' @param sessao Uma sessao criada por \code{\link{html_session}}
#' @param url O link para uma noticia
#'
#' @return Uma lista com o html, o titulo, os autores, as tags e o texto da noticia
#' @export
#'
#' @examples
#' url_noticia <- 'http://www.valor.com.br/brasil/5179248/ipc-s-tem-alta-de-033-em-outubro-aponta-fgv'
#' ler_noticia(url = url_noticia)
#'
ler_noticia <- function(sessao = html_session('http://www.valor.com.br'), url) {
  if (length(url) > 1) {
    com_lag <- function(url, sessao) {
      Sys.sleep(abs(rnorm(1)))
      try(ler_noticia(sessao, url))
    }
    return(purrr::map_df(url, com_lag, sessao = sessao))
  } # else {faça o resto}

  pagina <- sessao %>% jump_to(url) %>% read_html()

  noticia <- pagina %>% html_node('#content-area')

  datahora <- noticia %>% html_node('.date.submitted') %>% html_text() %>%
    stringr::str_replace('às', '') %>%
    lubridate::dmy_hm(tz = 'America/Sao_Paulo')

  titulo <- noticia %>% html_node('.title1') %>% html_text()

  autor <- noticia %>% html_node('.node-author-inner') %>% html_text()

  if (is.na(autor)) {
    autor <- noticia %>% html_node('.post-secao-valor-investe') %>% html_text() %>%
      stringr::str_extract('Postado.+\\r\\n') %>%
      stringr::str_replace('Postado.+: ', '') %>%
      stringr::str_replace_all('[\\r|\\n]', '')
  }

  tags <- noticia %>% html_nodes('.tags a') %>% html_text() %>%
    stringr::str_replace_all('\\n *', '')

  body <- noticia %>% html_nodes('.node-body')

  if (length(html_children(body)) == 0 ) {
    texto <- body %>% html_text() %>% paste0(collapse = '\n')
  } else {
    texto <- body %>% html_nodes('p') %>% html_text() %>%
      paste0(collapse = '\n')
  }

  tibble::tibble(url = url, datahora = datahora, titulo = titulo, autor = autor,
                 texto = texto, tags = list(tags))
}
