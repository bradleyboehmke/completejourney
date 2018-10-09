#' Campaign to household data.
#'
#' Data on the campaigns received by each household in the Complete Journey study.
#' Each household received a different set of campaigns.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 7,208 rows and 3 variables
#' \describe{
#' \item{description}{Type of campaign (TypeA, TypeB, TypeC)}
#' \item{household_key}{Uniquely identifies each household}
#' \item{campaign}{Uniquely identifies each campaign; Ranges 1-30}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' campaign_table
#'
#' # Join household metadata to campaign_table dataset
#' campaign_table %>%
#'   left_join(hh_demographics, "household_key")
#' }
#' }
"campaign_table"

#' @importFrom tibble tibble
NULL