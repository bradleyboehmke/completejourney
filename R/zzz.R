#' @keywords internal
.onAttach <- function(...) {
  welcome <- paste(
    "Welcome to the completejourney package!\n\n The data sets",
    "available through this package are quite sizeable;",
    "and too large to be contained within the package.",
    "Download them with the `get_data()` function.",
    "Consequently, you will need an active wifi connection", 
    "to download them from GitHub."
    )
  
  packageStartupMessage(paste(strwrap(welcome), collapse = "\n"))
}
