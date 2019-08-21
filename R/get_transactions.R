#' @title Get full Complete Journey transactions data set.
#'
#' @description 
#' The complete transactions data set for the Complete Journey is too large to be
#' contained within the package. \code{get_transactions()} provides an efficient
#' method for downloading the full data set from the source GitHub repository.
#' 
#' @param verbose Logical indicator whether or not to download silently.      
#'      
#' @source Downloading from \url{https://github.com/bradleyboehmke/completejourney/tree/master/data}.
#'   Data originated from 84.51°, Customer Journey study, \url{http://www.8451.com/area51/} 
#'   and were processes for analysis.
#' 
#' @return A data frame with 1,469,307 rows and 5 variables
#' 
#' @seealso \code{\link{transactions_sample}} for details regarding the variables.
#' 
#' @examples
#' \donttest{
#' # requires internet connection
#' transactions <- get_transactions()
#' }
#' @export
get_transactions <- function(verbose = FALSE) {
  download_data(which = 'transactions', verbose = verbose)
}