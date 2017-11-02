context('phantomJS()')

test_that('Retorna resultado esperado', {
  if (.Platform$OS.type == 'windows') {
    expect_silent(resposta <- phantomJS())
    expect_named(resposta, c('version', 'dir', 'path'))
  } else {
    expect_true(TRUE)
  }
})
