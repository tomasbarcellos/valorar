#' Realizar Login no site do Valor Economico
#'
#' @param sessao uma sessao criada por {\code{webdriver::Session}
#' @param email e-mail da conta realizar login no site do valor
#' @param senha senha para realizar login no site do valor
#'
#' @return Uma sessao conectada ao usuario
#' @export
#' @importFrom rvest follow_link html_attr html_children html_form html_node
#' @importFrom rvest html_nodes html_session html_text jump_to set_values submit_form
#' @importFrom xml2 read_html
#' @importFrom stats rnorm
#' @importFrom methods is
#' @importFrom magrittr '%>%'
#'
#' @examples
#' \dontrun{
#' pjs <- webdriver::run_phantomjs()
#' sessao <- webdriver::Session$new(port = pjs$port)
#' login(sessao, 'fulano@provedor.org', 'senha')
#' }
login <- function(sessao, email = NULL, senha = NULL) {
  if (methods::is(sessao) != "Session") {
    stop("`sessao` deve ser um objeto gerado com 'webdriver::Session$new()'", call. = FALSE)
  }

  url <- "https://login.globo.com/login/6668?url=&tam=WIDGET"
  sessao$go(url)

  if (file.exists(".valor")) {
    email <- readLines(".valor")[1]
    senha <- readLines(".valor")[2]
  } else {
    if (is.null(email)) {
      email <- rstudioapi::askForPassword()
    }
    if (is.null(senha)) {
      senha <- rstudioapi::askForPassword()
    }
  }

  elem_login <- sessao$findElement("#login")
  elem_pass <- sessao$findElement("#password")
  elem_login$sendKeys(email)
  elem_pass$sendKeys(senha)
  elem_btn_login <- sessao$findElement("button.button")
  elem_btn_login$click()

  sessao
}

#' Criar arquivo para login
#'
#' @return NULL
#' @export
#'
#' @examples
criar_auth <- function(){
  email <- rstudioapi::showPrompt("e-mail", "Digite seu e-mail", "")
  senha <- rstudioapi::askForPassword("senha")
  writeLines(c(email, senha), ".valor")
  invisible(NULL)
}

