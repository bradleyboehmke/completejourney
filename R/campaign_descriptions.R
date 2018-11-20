#' Campaign metadata.
#'
#' Campaign metadata for all campaigns run for the Customer Journey study. This
#' dataset gives the length of time for which a campaign runs. So, any coupons
#' received as part of a campaign are valid within the dates contained in this
#' dataset.
#'
#' @source 84.51, Customer Journey study, \url{http://www.8451.com/area51/}
#' @format A data frame with 30 rows and 4 variables
#' \describe{
#' \item{campaign_id}{Uniquely identifies each campaign; Ranges 1-30}
#' \item{campaign_type}{Type of campaign (Type A, Type B, Type C)}
#' \item{start_date}{Start date of campaign}
#' \item{end_date}{End date of campaign}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' campaign_descriptions
#'
#' # Join product campaign metadata to campaign_table dataset
#' campaigns %>%
#'   left_join(campaign_descriptions, "campaign_id")
#' }
#' }
"campaign_descriptions"

#' @importFrom tibble tibble
NULL