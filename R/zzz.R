#' @keywords internal
.onAttach <- function(...) {
  welcome <- paste(
    "Welcome to the completejourney package!\n\n The data sets",
    "available through this package are quite sizeable",
    "and too large to be contained within the package.",
    "Run `get_data()` in your console to download the", 
    "data sets from GitHub. An internet connection is required"
    )
  
  packageStartupMessage(paste(strwrap(welcome), collapse = "\n"))
}
