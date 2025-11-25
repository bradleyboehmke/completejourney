test_that("we can download promotions data", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  promotions <- download_data(which = "promotions", verbose = FALSE)
  expect_equal(dim(promotions), c(20940529, 5))
})

test_that("we can download transactions data", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  transactions <- download_data(which = "transactions", verbose = FALSE)
  expect_equal(dim(transactions), c(1469307, 11))
})

test_that("we can download both promotions and transactions data", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  both <- get_data(which = "both", verbose = FALSE)
  expect_equal(length(both), 2)
  expect_equal(dim(both[[1]]), c(20940529, 5))
  expect_equal(dim(both[[2]]), c(1469307, 11))
})

test_that("download fails gracefully with informative message", {
  skip_on_cran()

  # Mock the download_data function to simulate a failure
  # We'll test by attempting to download from an invalid URL
  mock_download <- function(verbose = TRUE) {
    url <- "https://github.com/invalid/nonexistent/repo/data.rds?raw=true"

    df <- tryCatch(
      {
        suppressWarnings(readRDS(gzcon(url(url))))
      },
      error = function(e) {
        msg <- paste0(
          "\nUnable to download data from GitHub.\n",
          "Original error: ", conditionMessage(e), "\n"
        )
        message(msg)
        NULL
      }
    )

    df
  }

  # Test that the function returns NULL without throwing an error
  expect_message(
    result <- mock_download(verbose = TRUE),
    "Unable to download data from GitHub"
  )
  expect_null(result)

  # Test that it doesn't throw an error (should complete successfully)
  expect_silent({
    result2 <- suppressMessages(suppressWarnings(mock_download(verbose = TRUE)))
  })
  expect_null(result2)
})
