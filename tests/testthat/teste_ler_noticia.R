context('ler_noticia()')

sessao <- suppressWarnings(login('', ''))

valor_investe <- 'http://www.valor.com.br/u/5179516'
valor_investe2 <- 'http://www.valor.com.br/u/5168464'

valor_aberta <- 'http://www.valor.com.br/u/5181607'
valor_fechada <- 'http://www.valor.com.br/u/5180727'

titulo_exp <- enc2native("Petróleo fecha em alta e atinge a máxima em mais de dois anos")
texto_exp <- enc2native("O economista-chefe do Banco Safra, Carlos Kawall, considera que as projeções de inflação do Comitê de Política Monetária (Copom) do Banco Central já comportam uma taxa Selic abaixo de 7% ao ano no fim do atual ciclo de distensão monetária.")
tags_exp <- list(enc2utf8(c("Crescimento econômico", "Henrique Meirelles",
                   "Rádio CBN", "República")))

test_that('leituras ocorrem sem erro', {
  expect_silent(resp1 <<- ler_noticia(sessao, valor_investe))
  expect_silent(ler_noticia(sessao, valor_investe2))
  expect_silent(resp2 <<- ler_noticia(sessao, valor_aberta))
  expect_silent(resp3 <<- ler_noticia(sessao, valor_fechada))
})


test_that('Meta informações da resposta', {
  expect_s3_class(resp1, 'tbl_df')
  expect_length(resp1, 6)
  expect_named(resp1, c( "url", 'datahora',"titulo", "autor", "texto", 'tags'))
  expect_equal(resp1$url, valor_investe)
  expect_is(resp3$datahora, c("POSIXct","POSIXt"))
  # expect_equal(enc2native(resp2$titulo), titulo_exp)
  expect_equal(resp1$autor, "Angela Bittencourt")
  # expect_equal(enc2native(resp3$texto), texto_exp)
  # expect_equal(enc2utf8(resp1$tags[[1]]), tags_exp[[1]])
})

