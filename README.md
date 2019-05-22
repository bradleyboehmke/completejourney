
<!-- README.md is generated from README.Rmd. Please edit that file -->

# completejourney

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis-CI Build
Status](https://travis-ci.org/bradleyboehmke/completejourney.svg?branch=master)](https://travis-ci.org/bradleyboehmke/completejourney)

## Overview

An R data package that provides access to data in the Complete Journey
Study provided by [84.51°](http://www.8451.com). The data represents
grocery store shopping transactions over one year from a group of 2,469
households who are frequent shoppers at a retailer. It contains all of
each household’s purchases, not just those from a limited number of
categories. For certain households, demographic information as well as
direct marketing contact history are included. The data sets provided by
`completejourney::get_data()` include:

  - `transactions`: products purchased by households
  - `products`: product metadata (brand, description, etc.)
  - `demographics`: household demographic data (age, income, family
    size, etc.)
  - `campaigns`: campaigns received by each household
  - `campaign_descriptions`: campaign metadata (length of time active)
  - `coupons`: coupon metadata (UPC code, campaign, etc.)
  - `coupon_redemptions`: coupon redemptions (household, day, UPC code,
    campaign)
  - `promotions`: product placement in mailers and in stores
    corresponding to advertising campaigns

## Installation

You can install `completejourney` from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("bradleyboehmke/completejourney")
```

## Downloading the Data

The data sets available through this package are quite sizeable; and too
large to be contained within the package. `get_data()` provides an
efficient method for downloading one or more of the data sets from the
source GitHub repository.

``` r
library(completejourney)
get_data(which = "all", verbose = FALSE)
```

Each downloaded data set is attached to the user search path and can be
called directly (i.e. `transactions`). For specifc details on a given
data set see the data sets respective help file (i.e. `?transactions`).

``` r
transactions
#> # A tibble: 1,469,307 x 11
#>    household_id store_id basket_id product_id quantity sales_value
#>    <chr>        <chr>    <chr>     <chr>         <dbl>       <dbl>
#>  1 900          330      31198570… 1095275           1        0.5 
#>  2 900          330      31198570… 9878513           1        0.99
#>  3 1228         406      31198655… 1041453           1        1.43
#>  4 906          319      31198705… 1020156           1        1.5 
#>  5 906          319      31198705… 1053875           2        2.78
#>  6 906          319      31198705… 1060312           1        5.49
#>  7 906          319      31198705… 1075313           1        1.5 
#>  8 1058         381      31198676… 985893            1        1.88
#>  9 1058         381      31198676… 988791            1        1.5 
#> 10 1058         381      31198676… 9297106           1        2.69
#> # … with 1,469,297 more rows, and 5 more variables: retail_disc <dbl>,
#> #   coupon_disc <dbl>, coupon_match_disc <dbl>, week <int>,
#> #   transaction_timestamp <dttm>
```

## Learn more

Learn more about the completejourney data, and the type of insights you
can look for, at
[https://bradleyboehmke.github.io/completejourney](https://bradleyboehmke.github.io/completejourney/).

## Source

The Complete Journey data is available at:
<http://www.8451.com/area51/>.
