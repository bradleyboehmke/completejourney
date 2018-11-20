
#' Household demographic metadata.
#'
#' Household demographic metadata for households participating in the Customer Journey study.
#' Due to nature of the data, the demographic information is not available for all
#' households.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 801 rows and 8 variables
#' \describe{
#' \item{household_id}{Uniquely identifies each household}
#' \item{age}{Estimated age range}
#' \item{marital_status}{Marital status (Married, Single, Unknown)}
#' \item{income}{Household income range}
#' \item{home_ownership}{Homeowner status (Homeowner, Renter, Unknown)}
#' \item{household_size}{Size of household up to 5+}
#' \item{household_comp}{Household composition description}
#' \item{kids_count}{Number of children present up to 3+}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' demographics
#'
#' # Transaction line items that don't have household metadata
#' transactions %>%
#'   anti_join(demographics, "household_id")
#' }
#' }
#' 
"demographics"

#' @importFrom tibble tibble
NULL