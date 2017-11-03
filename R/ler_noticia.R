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
    return(lapply(url, com_lag, sessao = sessao))
  } # else {faça o resto}

  pagina <- sessao %>% jump_to(url) %>% read_html()
  noticia <- pagina %>% html_node('.noticia_sem_img')
  titulo <- noticia %>% html_node('.title1') %>% html_text()
  autor <- noticia %>% html_node('.node-author-inner') %>% html_text()
  tags <- noticia %>% html_nodes('.tags a') %>% html_text() %>%
    stringr::str_replace_all('\\n *', '')
  body <- noticia %>% html_nodes('.node-body')

  if (length(html_children(body)) == 0 ) {
    texto <- body %>% html_text()
  } else {
    texto <- body %>% html_nodes('p') %>% html_text()
  }

  structure(
    tibble::tibble(html = list(pagina), titulo = titulo, autor = autor, tags = list(tags), texto = list(texto)),
    class = c('noticia', 'tbl_df', 'tbl', 'data.frame')
  )
}

#' Método para imprimir noticia
#'
#' @param x Objeto que vai imprimir
#' @param ... Outros argumento repassados para print
#'
#' @return O mesmo objeto passado em \code{x}
#' @export
#'
print.noticia <- function(x, ...) {
  X <- x
  tamanho <- nrow(x)
  cat('<', tamanho, ' noticia', if (tamanho > 1) 's' else '', '>\n\n', sep = '')

  if (tamanho > 3) x <- x[1:3, ]

  for (linha in seq_len(nrow(x))) {
    cat(toupper(x$titulo[linha]), '\n')
    cat(x$autor[linha], '\n\n')
    cat(substr(unlist(x$texto[linha])[1], 1, 200), '...\n...\n')
    cat('(', length(unlist(x$tags[linha])), ') tags: ',
        paste(unlist(x$tags[linha]), collapse = ', '), sep = '')
    cat('\n--------------------', if(linha ==3) '' else '\n\n')
  }

  invisible(X)
}
