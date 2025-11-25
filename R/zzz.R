#' @keywords internal
.onAttach <- function(...) {
  welcome <- paste(
    "Welcome to the completejourney package! Learn more about these data sets at http://bit.ly/completejourney." # nolint
  )

  packageStartupMessage(paste(strwrap(welcome), collapse = "\n"))
}
