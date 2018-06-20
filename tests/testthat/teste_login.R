context('login()')
pjs <- webdriver::run_phantomjs()
sessao <- webdriver::Session$new(port = pjs$port)

test_that('Meta informações da resposta', {
  expect_true(R6::is.R6(sessao))
})

# Se não está no servidor
if (file.exists('../../.valor')) {
  test_that('Faz login corretamente', {
    config <- readLines('../../.valor')

    expect_silent(sessao_logada <- login(sessao, config[1], config[2]))
  })
}
