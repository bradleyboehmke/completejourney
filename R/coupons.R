#' @title Coupon metadata.
#'
#' @description 
#' Coupon metadata for all coupons used in campaigns advertised to households
#' participating in the Customer Journey study.
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 116,204 rows and 3 variables
#' \itemize{
#' \item coupon_upc: Uniquely identifies each coupon (unique to household and campaign)
#' \item product_id: Uniquely identifies each product
#' \item campaign_id: Uniquely identifies each campaign
#' }
#' 
#' @docType data
#' @return \item{coupons}{a tibble}
#' @keywords datasets
#' 
#' @examples
#' \donttest{
#' # full data set
#' coupons
#'
#' # Join product metadata to coupon dataset
#' require("dplyr")
#' coupons %>%
#'   left_join(products, "product_id")
#' }
#' @importFrom tibble tibble
"coupons"