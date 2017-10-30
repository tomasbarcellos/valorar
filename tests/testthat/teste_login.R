context('login()')

library(valorar)

config <- readLines('../../.valor')

test_that('Meta informações da resposta', {
  expect_warning(sessao <- login('', ''), 'Houve falha no login')
  expect_s3_class(sessao, 'session')
})

# Se não está no servidor
if (grep('tomas', Sys.info()[['login']], ignore.case = TRUE)) {
  test_that('Faz login corretamente', {
    expect_message(sessao_logada <- login(config[1], config[2]), 'Login realizado com sucesso')
    expect_true(any(grepl('[0-9]{8}', sessao_logada$back)))
    expect_true(any(grepl('SESS', sessao_logada$response$cookies$name)))
  })
}
