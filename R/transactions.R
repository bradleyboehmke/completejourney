#' @title Sampling of the full Complete Journey transactions.
#'
#' @description 
#' A sampling of all products purchased by households within the Complete Journey
#' study. Each line found in this table is essentially the same line that would
#' be found on a store receipt. This is only a subsample of the complete
#' data set to keep package size manageable.
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 100,000 rows and 11 variables
#' \describe{
#'   \item{household_id}{Uniquely identifies each household}
#'   \item{store_id}{Uniquely identifies each store}
#'   \item{basket_id}{Uniquely identifies a purchase occasion}
#'   \item{product_id}{Uniquely identifies each product}
#'   \item{quantity}{Number of the products purchased during the trip}
#'   \item{sales_value}{Amount of dollars retailer receives from sale}
#'   \item{retail_disc}{Discount applied due to retailer's loyalty card program}
#'   \item{coupon_disc}{Discount applied due to manufacturer coupon}
#'   \item{coupon_match_disc}{Discount applied due to retailer's match of manufacturer coupon}
#'   \item{week}{Week of the transaction; Ranges 1-53}
#'   \item{transaction_timestamp}{Date and time of when the transaction occurred}
#' }
#' 
#' @seealso Use \code{\link{get_transactions}} to download the entire transactions
#'   data containing all 1,469,307 rows.
#'
#' @docType data
#' @name transactions_sample
#'
#' @examples
#' \donttest{
#' transactions_sample
#' }
#' @importFrom tibble tibble
NULL