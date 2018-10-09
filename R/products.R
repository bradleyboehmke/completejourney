#' Product metadata.
#'
#' Product metadata for all products purchased by households participating in
#' the Customer Journey study.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 92,353 rows and 7 variables
#' \describe{
#' \item{product_id}{Uniquely identifies each product}
#' \item{manufacturer}{Uniquely identifies each manufacturer}
#' \item{department}{Groups similar products together}
#' \item{brand}{Indicates Private or National label brand}
#' \item{commodity_desc}{Groups similar products together at lower level}
#' \item{sub_commodity_desc}{Groups similar products together at lowest level}
#' \item{curr_size_of_product}{Indicates package size (not available for all products)}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' products
#'
#' # Transaction line items that don't have product metadata
#' transaction_data %>%
#'   anti_join(product, "product_id")
#'
#' }
#' }
"products"

#' @importFrom tibble tibble
NULL