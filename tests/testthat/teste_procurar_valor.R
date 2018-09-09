context('procurar_valor()')

pjs <- webdriver::run_phantomjs()
sessao <- webdriver::Session$new(port = pjs$port)

test_that('Retorna sessao com resultado da busca', {
  expect_silent((busca <<- procurar_valor(sessao, 'desemprego')))
  expect_is(busca, 'character')
})
