#' Realizar Login no site do Valor
#'
#' @param email e-mail da conta realizar login no site do valor
#' @param senha senha para realizar login no site do valor
#'
#' @return Uma sessao conectada ao usuario
#' @export
#'
#' @examples
#'
login <- function(email, senha) {
  url <- 'http://www.valor.com.br/login'
  sessao <- html_session(url)
  indice_login <- sessao %>% html_nodes('form') %>% html_attr('id') %>%
    grep(pattern = 'login')
  formulario <- html_form(sessao)[[indice_login]]
  preenchido <- set_values(formulario, mail = email, pass = senha)
  submetido <- suppressMessages(submit_form(sessao, preenchido))
  submetido <- suppressMessages(submetido %>% follow_link('Login'))

  if (any(grepl('/[0-9]{8}/', submetido$url))) { #codigo de usuario no link
    message('Login realizado com sucesso')
  } else {
    warning('Houve falha no login\n', call. = FALSE)
  }

  submetido %>% jump_to('http://www.valor.com.br')
}
