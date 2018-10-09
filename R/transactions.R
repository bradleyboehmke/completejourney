#' @title Complete Journey transactions.
#'
#' @description All products purchased by households within the Complete Journey
#' study. Each line found in this table is essentially the same line that would
#' be found on a store receipt. This is only a subsample of the complete
#' data set to keep package size manageable.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 2,595,732 rows and 12 variables
#' \describe{
#'   \item{household_key}{Uniquely identifies each household}
#'   \item{basket_id}{Uniquely identifies a purchase occasion}
#'   \item{day}{Day when transaction occurred}
#'   \item{product_id}{Uniquely identifies each product}
#'   \item{quantity}{Number of the products purchased during the trip}
#'   \item{sales_value}{Amount of dollars retailer receives from sale}
#'   \item{store_id}{Uniquely identifies each store}
#'   \item{retail_disc}{Discount applied due to retailer's loyalty card program}
#'   \item{trans_time}{Time of day when the transaction occurred}
#'   \item{week_no}{Week of the transaction; Ranges 1-102}
#'   \item{coupon_disc}{Discount applied due to manufacturer coupon}
#'   \item{coupon_match_disc}{Discount applied due to retailer's match of manufacturer coupon}
#' }
#'
#'
#' @examples
#'   head(transactions)
"transactions"

#' @importFrom tibble tibble
NULL