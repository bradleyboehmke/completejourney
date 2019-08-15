#' @keywords internal
download_data <- function(which = "both", verbose = TRUE) {
  dataset_names <- c("promotions", "transactions")
  
  if (any(which != "both")) {
    dataset_names <- dataset_names[dataset_names %in% which]
  }
  
  progress_names <- stringr::str_pad(dataset_names, max(nchar(dataset_names)), side = "right")
 
  pb <- progress::progress_bar$new(
    format = ":current/:total (:percent) [:bar] downloading :what", 
    total = length(dataset_names),
    clear = FALSE
    )
  
  if (verbose) message("Loading completejourney data sets from GitHub")
  
  df_list = list()
  
  for (i in seq_along(dataset_names)) {
    if (verbose) pb$tick(tokens = list(what = progress_names[i]))
      
      url = sprintf("https://github.com/bradleyboehmke/completejourney/blob/master/data/%s.rds?raw=true", dataset_names[i])
      df = readRDS(gzcon(url(url)))
      df_list[[dataset_names[i]]] <- df
  }
  msg <- "Download complete. Learn more about these data sets at http://bit.ly/completejourney"
  if (verbose) message(paste(strwrap(msg), collapse = "\n"))
  
  if (length(df_list) == 1 ) df_list <- df_list[[1]]
  return(df_list)
}

#' @keywords internal
'%notin%' <- function(x, y) !('%in%'(x, y))

#' Assign values to names
#'
#' See \code{\link[zeallot]{\%<-\%}} for more details.
#' 
#' @param x A name structure.
#' @param value A list of values, vector of values, or R objects to assign.
#'
#' @name %<-%
#' @rdname multi-assign
#' @export
#' @import zeallot
#' @usage x \%<-\% value
NULL

#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom dplyr %>%
#' @usage lhs \%>\% rhs
NULL