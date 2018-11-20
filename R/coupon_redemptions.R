#' Coupon redemption data.
#'
#' Coupon data identifying the coupons that each household redeemed in the Complete
#' Journey study.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 2,318 rows and 4 variables
#' \describe{
#'   \item{household_id}{Uniquely identifies each household}
#'   \item{coupon_upc}{Uniquely identifies each coupon (unique to household and campaign)}
#'   \item{campaign}{Uniquely identifies each campaign}
#'   \item{day}{Day when transaction occurred}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' coupon_redemptions
#'
#' # Join coupon metadata to coupon_redempt dataset
#' coupon_redemptions %>%
#'   left_join(coupons, "coupon_upc")
#' }
#' }
"coupon_redemptions"

#' @importFrom tibble tibble
NULL