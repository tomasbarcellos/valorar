#' Pegar caminho e versao do phantomJS
#'
#' @param version ...
#'
#' @return caminho do phantomJS
#'
#' @importFrom utils getFromNamespace
#'
phantomJS <- function (version = "2.1.1", check = TRUE, verbose = FALSE) {
  stopifnot(is.character(version))
  phantom_check <- utils::getFromNamespace('phantom_check', 'wdman')
  phantom_ver <- utils::getFromNamespace('phantom_ver', 'wdman')

  phantomcheck <- phantom_check(verbose, check)
  phantomplat <- phantomcheck[["platform"]]
  phantom_ver(phantomplat, version)
}
