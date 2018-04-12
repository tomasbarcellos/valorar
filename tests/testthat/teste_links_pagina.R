context('links_pagina()')

test_that('Retorna links como caracteres', {
  # expect_warning(links <<- login('', '') %>% links_pagina(), 'Houve falha no login')
  expect_warning(links <<- login('', '') %>% links_pagina(), "globo.com")
  expect_true(is.character(links))
})

test_that('Funciona com argumentos implicitos e explicitos', {
  expect_silent(resposta1 <<- rvest::html_session('http://www.valor.com.br') %>%
                  read_html() %>% links_pagina())
  expect_silent(resposta2 <<- links_pagina(css = '.teaser-title a'))
  expect_identical(resposta1, resposta2)
})
