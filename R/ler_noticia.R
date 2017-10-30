#' Tira informações da noticia
#'
#' @param sessao Uma sessao
#' @param url O link para uma noticia
#'
#' @return Uma lista com o html, o titulo, os autores, as tags e o texto da noticia
#' @export
#'
#' @examples
#' # Comentario
ler_noticia <- function(sessao, url) {
  if (length(url) > 1) {
    com_lag <- function(url, sessao) {
      Sys.sleep(abs(rnorm(1)))
      try(ler_noticia(sessao, url))
    }
    return(lapply(url, com_lag, sessao = sessao))
  }

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
    list(html = pagina, titulo = titulo, autor = autor, tags = tags, texto = texto),
    class = 'noticia'
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
#' @examples
#' #' # Comentario
print.noticia <- function(x, ...) {
  cat('<noticia>\n')
  cat(toupper(x$titulo), '\n')
  cat(x$autor, '\n\n')
  cat(substr(x$texto, 1, 80), '...\n...\n')
  cat('(', length(x$tags), ') tags: ', paste(x$tags, collapse = ', '), sep = '')
  invisible(x)
}
