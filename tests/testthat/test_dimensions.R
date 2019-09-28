test_that("built in data dimensions are correct", {
  skip_on_cran()
  skip_on_ci()
  
  expect_equal(dim(campaigns), c(6589, 2))
  expect_equal(dim(campaign_descriptions), c(27, 4))
  expect_equal(dim(coupon_redemptions), c(2102, 4))
  expect_equal(dim(coupons), c(116204, 3))
  expect_equal(dim(demographics), c(801, 8))
  expect_equal(dim(products), c(92331, 7))
  expect_equal(dim(promotions_sample), c(360535, 5))
  expect_equal(dim(transactions_sample), c(75000, 11))
})