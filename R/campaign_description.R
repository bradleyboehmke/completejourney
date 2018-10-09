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
#' \item{description}{Type of campaign (TypeA, TypeB, TypeC)}
#' \item{campaign}{Uniquely identifies each campaign; Ranges 1-30}
#' \item{start_day}{Start date of campaign}
#' \item{end_day}{End date of campaign}
#' }
#' @examples
#' \dontrun{
#' if (require("dplyr")) {
#' campaign_desc
#'
#' # Join product campaign metadata to campaign_table dataset
#' campaign_table %>%
#'   left_join(campaign_description, "campaign")
#' }
#' }
"campaign_description"

#' @importFrom tibble tibble
NULL