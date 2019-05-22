#' Download Complete Journey Data
#'
#' The data sets available through this package are quite sizeable; and too 
#' large to be contained within the package. \code{get_data()} provides an
#' efficient method for downloading one or more of the data sets from the
#' source GitHub repository.
#' 
#' @param which Character string of one or more data sets to be downloaded.
#'   Can be one of the following; default is \code{"all"}:
#'   \itemize{
#'       \item{"all"}
#'       \item{"compaigns"}
#'       \item{"campaign_descriptions"}
#'       \item{"coupons"}
#'       \item{"coupon_redemptions"}
#'       \item{"demographics"}
#'       \item{"products"}
#'       \item{"promotions"}
#'       \item{"transactions"}
#'      }
#' @param verbose Logical indicator whether or not to download silently.      
#'      
#' @source Downloading from \url{https://github.com/bradleyboehmke/completejourney/tree/master/data}.
#'   Data originated from 84.51°, Customer Journey study, \url{http://www.8451.com/area51/} 
#'   and were processes for analysis.
#'   
#' @return Each downloaded data set is attached to the user search path and can
#'   be called directly (i.e. \code{transactions}). For specifc details on a 
#'   given data set see the data sets respective help file (i.e. \code{?transactions}).
#'   
#' @examples
#' \donttest{
#' # download all data sets
#' get_data(which = "all", verbose = FALSE)
#' 
#' # download transactions data
#' get_data(which = "transactions", verbose = FALSE)
#' 
#' # download multiple data sets
#' get_data(which = c("transactions", "promotions"), verbose = FALSE)
#' }
#' @export
get_data <- function(which = "all", verbose = TRUE) {
  
  valid <- c(
    "all", 
    "campaigns",
    "campaign_descriptions",
    "coupons",
    "coupon_redemptions",
    "demographics",
    "products",
    "promotions",
    "transactions"
    )
  
  if (any(which %notin% valid)) {
    quoted_valids <- paste0("'", paste0(valid, collapse = "', '"), "'")
    quoted_valids <- paste(strwrap(quoted_valids), collapse = "\n")
    stop("`which` must be one of the following:\n", quoted_valids)
  }
  
  download_data(which = which, verbose = verbose)
  
}



