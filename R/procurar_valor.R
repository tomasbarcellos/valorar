#' Title
#'
#' @param termo Termo buscado
#' @param sessao Sessao
#' @param paginas numero de paginas que serao retornadas
#'
#' @return Uma sessao com resultados da busca
#' @export
#'
#' @examples
procurar_valor <- function(termo, sessao = rvest::html_session('http://www.valor.com.br'), paginas = 5) {
  url <- paste0('http://www.valor.com.br/busca/', termo)
  tf <- tempfile(fileext = '.html')

  arq <- switch(Sys.info()["sysname"],
                Linux = wdman:::os_arch("linux"), Windows = 'windows',
                Darwin = 'macos', stop("Unknown OS"))

  caminho <- wdman:::phantom_ver(arq, '2.1.1')

  JS <- if(file.exists('phantom.js')) 'phantom.js' else '../../phantom.js'
  system('cmd.exe', input = paste(caminho$path, JS, url, tf))

  html <- read_html(tf)
  links <- html %>% html_nodes('.title2 a') %>% html_attr('href')
  resultados <- html %>% html_nodes('.search-result-term') %>% html_text() %>%
    `[[`(1) %>%
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








