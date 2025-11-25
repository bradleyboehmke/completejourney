#' @title Campaigns to household data.
#'
#' @description
#' Data on the campaigns received by each household in the Complete Journey study.
#' Each household received a different set of marketing campaigns.
#'
#' @source 84.51°, Customer Journey study, \url{https://www.8451.com/area51/}
#' @format A data frame with 6,589 rows and 2 variables
#' \itemize{
#' \item campaign_id: Uniquely identifies each campaign; Ranges 1-27
#' \item household_id: Uniquely identifies each household
#' }
#'
#' @docType data
#' @return \item{campaigns}{a tibble}
#' @keywords datasets
#'
#' @examples
#' \donttest{
#' # full data set
#' campaigns
#'
#' # Join household demographics metadata to campaigns dataset
#' require("dplyr")
#' campaigns %>%
#'   left_join(demographics, "household_id")
#' }
#' @importFrom tibble tibble
"campaigns"
