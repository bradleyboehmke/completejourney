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
  
  both <- get_data(which = 'both', verbose = FALSE)
  expect_equal(length(both), 2)
  expect_equal(dim(both[[1]]), c(20940529, 5))
  expect_equal(dim(both[[2]]), c(1469307, 11))
})