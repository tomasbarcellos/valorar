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
  url <- 'http://www.valor.com.br/login?'
  sessao <- html_session(url)
  indice_login <- sessao %>% html_nodes('form') %>% html_attr('id') %>%
    `==`('user-login') %>% which()
  formulario <- html_form(sessao)[[indice_login]]
  preenchido <- set_values(formulario, mail = email, pass = senha)
  submetido <- submit_form(sessao, preenchido)
  confirmacao <- submetido %>% html_nodes('ul') %>% html_text()
  if (any(grepl('Login', confirmacao))) {
    warning('Houve falha no login\n', call. = FALSE)
  } else {
    message('Login realizado com sucesso')
    print(confirmacao)
  }
  submetido
}
