#' Tira informações da noticia
#'
#' @param sessao Uma sessao
#' @param url O link para uma noticia
#'
#' @return Uma lista com o html, o titulo, os autores, as tags e o texto da noticia
#' @export
#'
#' @examples
ler_noticia <- function(sessao, url) {
  pagina <- sessao %>% jump_to(url) %>% read_html()
  noticia <- pagina %>% html_node('.noticia_sem_img')
  titulo <- noticia %>% html_node('.title1') %>% html_text()
  autor <- noticia %>% html_node('.node-author-inner') %>% html_text()
  tags <- noticia %>% html_nodes('.tags a') %>% html_text() %>%
    stringr::str_replace_all('\\n *', '')
  texto <- noticia %>% html_nodes('.node-body') %>% html_text()

  structure(
    list(html = pagina, titulo = titulo, autor = autor, tags = tags, texto = texto),
    class = 'noticia'
  )
}

print.noticia <- function(x, ...) {
  cat('<noticia>\n')
  cat(toupper(x$titulo), '\n')
  cat(x$autor, '\n\n')
  cat(substr(x$texto, 1, 80), '...\n...\n')
  cat('(', length(x$tags), ') tags: ', paste(x$tags, collapse = ', '), sep = '')
}
