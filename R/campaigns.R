#' Campaigns to household data.
#'
#' Data on the campaigns received by each household in the Complete Journey study.
#' Each household received a different set of marketing campaigns.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 7,208 rows and 3 variables
#' \describe{
#' \item{household_id}{Uniquely identifies each household}
#' \item{campaign}{Uniquely identifies each campaign; Ranges 1-30}
#' \item{description}{Type of campaign (TypeA, TypeB, TypeC)}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' campaigns
#'
#' # Join household demographics metadata to campaigns dataset
#' campaigns %>%
#'   left_join(demographics, "household_id")
#' }
#' }
"campaigns"

#' @importFrom tibble tibble
NULL