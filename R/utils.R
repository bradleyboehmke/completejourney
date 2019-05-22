#' @keywords internal
# load_url from: https://stackoverflow.com/questions/24846120/importing-data-into-r-rdata-from-github
load_url <- function (url, ..., sha1 = NULL) {
  # based very closely on code for devtools::source_url
  stopifnot(is.character(url), length(url) == 1)
  temp_file <- tempfile()
  on.exit(unlink(temp_file))
  request <- httr::GET(url)
  httr::stop_for_status(request)
  writeBin(httr::content(request, type = "raw"), temp_file)
  file_sha1 <- digest::digest(file = temp_file, algo = "sha1")
  if (is.null(sha1)) {
    #message("SHA-1 hash of file is ", file_sha1)
  } else {
    if (nchar(sha1) < 6) {
      stop("Supplied SHA-1 hash is too short (must be at least 6 characters)")
    }
    file_sha1 <- substr(file_sha1, 1, nchar(sha1))
    if (!identical(file_sha1, sha1)) {
      stop("SHA-1 hash of downloaded file (", file_sha1, 
           ")\n  does not match expected value (", sha1, 
           ")", call. = FALSE)
    }
  }
  #load(temp_file, envir = .GlobalEnv)
  attach(temp_file, warn.conflicts = FALSE)
}

#' @keywords internal
download_data <- function(which = "all", verbose = TRUE) {
  dataset_names <- c("campaigns", "campaign_descriptions", "coupons", "coupon_redemptions",
                     "demographics", "products", "promotions", "transactions")
  
  if (any(which != "all")) {
    dataset_names <- dataset_names[dataset_names %in% which]
  }
  
  progress_names <- stringr::str_pad(dataset_names, max(nchar(dataset_names)), side = "right")
 
  pb <- progress::progress_bar$new(
    format = ":current/:total (:percent) [:bar] downloading :what", 
    total = length(dataset_names),
    clear = FALSE
    )
  
  if (verbose) message("Loading completejourney data sets from GitHub")
  
  for (i in seq_along(dataset_names)) {
    if (verbose) pb$tick(tokens = list(what = progress_names[i]))
      
    load_url(sprintf("https://github.com/bradleyboehmke/completejourney/blob/master/data/%s.rda?raw=true", dataset_names[i]))
  }
  msg <- "Download complete. Learn more about these data sets at https://bradleyboehmke.github.io/completejourney"
  if (verbose) message(paste(strwrap(msg), collapse = "\n"))
}

#' @keywords internal
'%notin%' <- function(x, y) !('%in%'(x, y))
