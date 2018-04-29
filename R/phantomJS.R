#' #' Pegar caminho e versao do phantomJS
#' #'
#' #' @param version versao do phantomJS que sera buscada
#' #' @param check Novas versoes de phantomJS devem ser buscadas e baixadas?
#' #' @param verbose A funcao deve ser prolixa?
#' #'
#' #' @return caminho do phantomJS
#' #'
#' #' @importFrom utils getFromNamespace
#' #'
#' phantomJS <- function (version = "2.1.1", check = TRUE, verbose = FALSE) {
#'   stopifnot(is.character(version))
#'   phantom_check <- utils::getFromNamespace('phantom_check', 'wdman')
#'   phantom_ver <- utils::getFromNamespace('phantom_ver', 'wdman')
#'
#'   phantomcheck <- phantom_check(verbose, check)
#'   phantomplat <- phantomcheck[["platform"]]
#'   phantom_ver(phantomplat, version)
#' }
