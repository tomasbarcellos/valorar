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
procurar_valor <- function(termo, sessao = rvest::html_session('http://www.valor.com.br'), paginas = 5) {
  requireNamespace('wdman', quietly = TRUE)
  requireNamespace('binman', quietly = TRUE)
  url <- paste0('http://www.valor.com.br/busca/', termo)
  tf <- tempfile(fileext = '.html')

  # os_arch <- utils::getFromNamespace('os_arch', 'wdman')
  # phantom_ver <- utils::getFromNamespace('phantom_ver', 'wdman')
  #
  # arq <- switch(Sys.info()["sysname"],
  #               Linux = os_arch("linux"), Windows = 'windows',
  #               Darwin = 'macos', stop("Unknown OS"))
  #
  # caminho <- phantom_ver(arq, '2.1.1')

  JS <- system.file('js','phantom.js', package = 'valorar')

  system('cmd.exe', input = paste(phantomJS()$path, JS, url, tf), intern = TRUE)

  html <- read_html(tf)
  links <- html %>% html_nodes('.title2 a') %>% html_attr('href')
  resultados <- html %>% html_nodes('.search-result-term') %>% html_text() %>%
    magrittr::extract2(1) %>%
    gsub(pattern = '\t', replacement = '') %>%
    stringr::str_extract('de [0-9]+') %>%
    gsub(pattern = 'de *', replacement = '') %>%
    as.numeric()

  # paginacao: paste0(url, '?page=', 1, '&method=ajax')

  attr(sessao, 'pagina') <- 1
  attr(sessao, 'resultados') <- resultados
  attr(sessao, 'links') <- links
  sessao
}








