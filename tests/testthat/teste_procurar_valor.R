context('procurar_valor()')

test_that('Retorna sessao com resultado da busca', {
  expect_silent((busca <<- procurar_valor('desemprego')))
  expect_is(busca, 'character')
})
