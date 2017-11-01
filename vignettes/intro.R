## ---- eval = FALSE-------------------------------------------------------
#  # install.packages('devtools')
#  devtools::install_github('tomasbarcellos/valorar')

## ---- eval = FALSE-------------------------------------------------------
#  library(valorar)
#  email <- 'meu-email@provedor'
#  senha <- 'minha_senha'
#  sessao_logada <- login(email, senha)
#  # dar uma olhada do objeto da sessao
#  sessao_logada

## ---- echo = FALSE-------------------------------------------------------
library(valorar)
sessao_logada <- login('', '')
# dar uma olhada do objeto da sessao
sessao_logada

