#' @title Campaign metadata.
#'
#' @description
#' Campaign metadata for all campaigns run for the Customer Journey study. This
#' dataset gives the length of time for which a campaign runs. So, any coupons
#' received as part of a campaign are valid within the dates contained in this
#' dataset.
#'
#' @source 84.51°, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 27 rows and 4 variables
#' \itemize{
#' \item campaign_id: Uniquely identifies each campaign; Ranges 1-27
#' \item campaign_type: Type of campaign (Type A, Type B, Type C)
#' \item start_date: Start date of campaign
#' \item end_date: End date of campaign
#' }
#'
#' @docType data
#' @return \item{campaign_descriptions}{a tibble}
#' @keywords datasets
#'
#' @examples
#' \donttest{
#' # full data set
#' campaign_descriptions
#'
#' # Join product campaign metadata to campaign_table dataset
#' require("dplyr")
#' campaigns %>%
#'   left_join(campaign_descriptions, "campaign_id")
#' }
#' @importFrom tibble tibble
"campaign_descriptions"
