context('procurar_valor()')

test_that('Retorna sessao com resultado da busca', {
  # if (.Platform$OS.type == 'windows') {
    expect_s3_class((busca <<- procurar_valor('desemprego')), 'session')
    expect_false(is.null(attr(busca, 'resultados')))
    expect_false(is.null(attr(busca, 'pagina')))
  # } else {
  #   expect_true(TRUE)
  # }
})
