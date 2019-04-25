#' Campaigns to household data.
#'
#' Data on the campaigns received by each household in the Complete Journey study.
#' Each household received a different set of marketing campaigns.
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 6,589 rows and 2 variables
#' \describe{
#' \item{campaign_id}{Uniquely identifies each campaign; Ranges 1-27}
#' \item{household_id}{Uniquely identifies each household}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' # if data hasn't been imported yet
#' import_data(which = "all")
#' 
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