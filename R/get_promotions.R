#' @title Get full Complete Journey promotions data set.
#'
#' @description 
#' The complete promotions data set for the Complete Journey is too large to be
#' contained within the package. \code{get_promotions()} provides an efficient
#' method for downloading the full data set from the source GitHub repository.
#' 
#' @param verbose Logical indicator whether or not to download silently.      
#'      
#' @source Downloading from \url{https://github.com/bradleyboehmke/completejourney/tree/master/data}.
#'   Data originated from 84.51°, Customer Journey study, \url{http://www.8451.com/area51/} 
#'   and were processes for analysis.
#' 
#' @return A data frame with 20,940,529 rows and 5 variables
#' 
#' @seealso \code{\link{promotions_sample}} for details regarding the variables.
#' 
#' @examples
#' \donttest{
#' # requires internet connection
#' promotions <- get_promotions()
#' }
#' @export
get_promotions <- function(verbose = FALSE) {
  download_data(which = 'promotions', verbose = verbose)
}