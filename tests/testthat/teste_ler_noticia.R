context('ler_noticia()')

sessao <- suppressWarnings(login('', ''))
links <- sessao %>% read_html() %>% html_nodes('.teaser-title a') %>%
  html_attr('href') %>%  `[`(. != '') %>%
  ifelse(test = grepl(pattern = '\\bhttp', x = .), no = paste0('http://www.valor.com.br', .))

valor_investe <- 'http://www.valor.com.br/u/5179516'

test_that('leituras ocorrem sem erro', {
  expect_silent(
    noticia1 <<- ler_noticia(sessao, links[1])
  )
  expect_error(ler_noticia(sessao, valor_investe), 'xml_missing')
})


test_that('Meta informações da resposta', {
  expect_s3_class(noticia1, 'noticia')
  expect_length(noticia1, 5)
  expect_named(noticia1, c( "html", "titulo", "autor", "tags", "texto" ))
})

