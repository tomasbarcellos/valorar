context('ler_noticia()')

sessao <- html_session("http://www.valor.com.br")

valor_investe <- 'http://www.valor.com.br/u/5179516'
valor_investe2 <- 'http://www.valor.com.br/u/5168464'

valor_aberta <- 'http://www.valor.com.br/u/5181607'
valor_fechada <- 'http://www.valor.com.br/u/5180727'

titulo_exp <- stringi::stri_unescape_unicode(
  "Petr\\u00f3leo fecha em alta e atinge a m\\u00e1xima em mais de dois anos"
)
texto_exp <- stringi::stri_unescape_unicode(
  "O economista-chefe do Banco Safra, Carlos Kawall, considera que as proje\\u00e7\\u00f5es de infla\\u00e7\\u00e3o do Comit\\u00ea de Pol\\u00edtica Monet\\u00e1ria (Copom) do Banco Central j\\u00e1 comportam uma taxa Selic abaixo de 7% ao ano no fim do atual ciclo de distens\\u00e3o monet\\u00e1ria."
)
tags_exp <- list(stringi::stri_unescape_unicode(
  c("CBN (R\\u00e1dio)", "Desenvolvimento econ\\u00f4mico",
    "Henrique Meirelles", "Rep\\u00fablica")
))

test_that('leituras ocorrem sem erro', {
  expect_silent(resp1 <<- ler_noticia(sessao, valor_investe))
  expect_silent(ler_noticia(sessao, valor_investe2))
  expect_silent(resp2 <<- ler_noticia(sessao, valor_aberta))
  expect_silent(resp3 <<- ler_noticia(sessao, valor_fechada))
})
context('ler_noticia(), objeto')
test_that("", {
  expect_s3_class(resp1, 'tbl_df')
  expect_length(resp1, 6)
  expect_named(resp1, c( "url", 'datahora',"titulo", "autor", "texto", 'tags'))
  expect_equal(resp1$url, valor_investe)
  expect_is(resp3$datahora, c("POSIXct","POSIXt"))
})

context('ler_noticia(), conteúdo')

test_that('Resposta sao como esperadas', {
  expect_equal(resp2$titulo, titulo_exp)
  expect_equal(resp1$autor, "Angela Bittencourt")
  expect_equal(resp3$texto, texto_exp)
  expect_equal(resp1$tags, tags_exp)
})

