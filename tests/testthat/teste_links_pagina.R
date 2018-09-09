context('links_pagina()')

sessao <- html_session("http://www.valor.com.br")

test_that('Retorna links como caracteres', {
  # expect_warning(links <<- login('', '') %>% links_pagina(), 'Houve falha no login')
  expect_silent(links <<- sessao %>% links_pagina())
  expect_true(is.character(links))
})

