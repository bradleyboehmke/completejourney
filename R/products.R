#' Product metadata.
#'
#' Product metadata for all products purchased by households participating in
#' the Customer Journey study.
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 92,331 rows and 7 variables
#' \describe{
#' \item{product_id}{Uniquely identifies each product}
#' \item{manufacturer_id}{Uniquely identifies each manufacturer}
#' \item{department}{Groups similar products together}
#' \item{brand}{Indicates Private or National label brand}
#' \item{product_category}{Groups similar products together at lower level}
#' \item{product_type}{Groups similar products together at lowest level}
#' \item{package_size}{Indicates package size (not available for all products)}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' # if data hasn't been imported yet
#' import_data(which = "all")
#' 
#' products
#'
#' # Transaction line items that don't have product metadata
#' transactions %>%
#'   anti_join(products, "product_id")
#'
#' }
#' }
"products"

#' @importFrom tibble tibble
NULL