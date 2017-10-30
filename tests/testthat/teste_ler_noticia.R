context('ler_noticia()')

library(valorar)

sessao <- suppressWarnings(login('', ''))
links <- sessao %>% read_html() %>% html_nodes('.teaser-title a') %>%
  html_attr('href') %>%  `[`(. != '') %>%
  ifelse(test = grepl(pattern = '\\bhttp', x = .), no = paste0('http://www.valor.com.br', .))

noticia1 <- ler_noticia(sessao, links[1])

test_that('Meta informações da resposta', {
  expect_s3_class(noticia1, 'noticia')
  expect_length(noticia1, 5)
  expect_named(noticia1, c( "html", "titulo", "autor", "tags", "texto" ))
})

