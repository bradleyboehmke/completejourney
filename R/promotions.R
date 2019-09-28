#' @title Sampling of the full promotions data set.
#' 
#' @description 
#' A sampling of the promotions data from the Complete Journey study signifying 
#' whether a given product was featured in the weekly mailer or was part of an 
#' in-store display (other than regular product placement). 
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 360,535 rows and 5 variables
#' \itemize{
#'   \item product_id: Uniquely identifies each product
#'   \item store_id: Uniquely identifies each store
#'   \item display_location: Display location  (see details for range of values)
#'   \item mailer_location: Mailer location (see details for range of values)
#'   \item week: Week of the transaction; Ranges 1-53
#' }
#' @section Display Location Codes:
#' \itemize{
#'   \item 0 - Not on Display
#'   \item 1 - Store Front
#'   \item 2 - Store Rear
#'   \item 3 - Front End Cap
#'   \item 4 - Mid-Aisle End Cap
#'   \item 5 - Rear End Cap
#'   \item 6 - Side-Aisle End Cap
#'   \item 7 - In-Aisle
#'   \item 9 - Secondary Location Display
#'   \item A - In-Shelf
#' }
#' @section Mailer Location Codes:
#' \itemize{
#'   \item 0 - Not on ad
#'   \item A - Interior page feature
#'   \item C - Interior page line item
#'   \item D - Front page feature
#'   \item F - Back page feature
#'   \item H - Wrap from feature
#'   \item J - Wrap interior coupon
#'   \item L - Wrap back feature
#'   \item P - Interior page coupon
#'   \item X - Free on interior page
#'   \item Z - Free on front page, back page or wrap
#' }
#' 
#' @seealso Use \code{\link{get_promotions}} to download the entire promotions
#'   data containing all 20,940,529 rows.
#' 
#' @docType data
#' @return \item{promotions_sample}{a tibble}
#' @keywords datasets
#' 
#' @examples
#' \donttest{
#' # sampled promotions data set
#' promotions_sample
#'
#' # Join promotions to transactions to analyze
#' # product promotion/location
#' require("dplyr")
#' transactions_sample %>%
#'   left_join(promotions_sample,
#'             c("product_id", "store_id", "week"))
#' }
#' @importFrom tibble tibble
"promotions_sample"