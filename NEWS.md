## completejourney 1.0.0

This package provides access to 8 datasets that cover retail shopping transactions for 2,469 
households over one year. In addition to the transaction details, the datasets 
contain 'metadata' on the products, coupons, campaigns, and promotions.

### Features

  * Add `completejourney` vignette to demonstrate basic usage (#1)
  * Add a pkgdown site as a web resource for the package (#3)
  * Rename key variables to all be character strings with the column name ending in `"id"` (#7)
  * Remove confusing or inconsistent data in the `demographics` and `products` datasets (#7)
  * Restrict the data to only 2017 to remove some anomalous spending patterns and 
  reduce the overall size of the package (#7)
  * Re-numbered campaign ID to be 1-27 (#12)
  * Created importing capabilities so that large data sets do not need to be included
    in package (due to size).

### Bug Fixes

  * NONE
