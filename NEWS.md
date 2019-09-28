# completejourney 1.1.0 (2019-09-28)

## New features

  * Added an internet check with `curl::has_internet()` and condition handling to 
    provide informative error when downloading online data sets.

## Bug fixes

  * Removed `^data$` from .Rbuildignore and only specified ignoring the .rds 
    files. This resolved issue ([#14](https://github.com/bradleyboehmke/completejourney/issues/14)). 
    As a consequence, the package was too large now that the build included the 
    required data sets so I downsampled the `transactions_sample` and 
    `promotions_sample` data sets.

# completejourney 1.0.0 (2019-08-23)

## New features

  * Add `completejourney` vignette to demonstrate basic usage (#1)
  * Add a pkgdown site as a web resource for the package (#3)
  * Rename key variables to all be character strings with the column name ending in `"id"` (#7)
  * Remove confusing or inconsistent data in the `demographics` and `products` datasets (#7)
  * Restrict the data to only 2017 to remove some anomalous spending patterns and 
  reduce the overall size of the package (#7)
  * Re-numbered campaign ID to be 1-27 (#12)
  * Created importing capabilities so that large data sets do not need to be included
    in package (due to size).

## Bug fixes

  * NONE
