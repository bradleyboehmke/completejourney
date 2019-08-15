
<!-- README.md is generated from README.Rmd. Please edit that file -->

# completejourney

[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis-CI Build
Status](https://travis-ci.org/bradleyboehmke/completejourney.svg?branch=master)](https://travis-ci.org/bradleyboehmke/completejourney)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/bradleyboehmke/completejourney?branch=master&svg=true)](https://ci.appveyor.com/project/bradleyboehmke/completejourney)

## Overview

An R data package that provides access to data in the Complete Journey
Study provided by [84.51°](http://www.8451.com). The data represents
grocery store shopping transactions over one year from a group of 2,469
households who are frequent shoppers at a retailer. It contains all of
each household’s purchases, not just those from a limited number of
categories. For certain households, demographic information as well as
direct marketing contact history are included.

  - `transactions_sample`: a sampling of the products purchased by
    households
  - `products`: product metadata (brand, description, etc.)
  - `demographics`: household demographic data (age, income, family
    size, etc.)
  - `campaigns`: campaigns received by each household
  - `campaign_descriptions`: campaign metadata (length of time active)
  - `coupons`: coupon metadata (UPC code, campaign, etc.)
  - `coupon_redemptions`: coupon redemptions (household, day, UPC code,
    campaign)
  - `promotions_sample`: a sampling of the product placement in mailers
    and in stores corresponding to advertising campaigns

## Installation

You can install `completejourney` from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("bradleyboehmke/completejourney")
```

``` r
library(completejourney)
```

## Downloading full data sets

Due to the size of the transactions and promotions data, the package
provides a sampling of the data built-in with `transactions_sample` and
`promotions_sample`. However, you can access the full promotions and
transactions data sets from the source GitHub repository with the
following:

``` r
# get the full transactions data set
transactions <- get_transactions()
transactions
## # A tibble: 1,469,307 x 11
##    household_id store_id basket_id product_id quantity sales_value retail_disc
##    <chr>        <chr>    <chr>     <chr>         <dbl>       <dbl>       <dbl>
##  1 900          330      31198570… 1095275           1        0.5        0    
##  2 900          330      31198570… 9878513           1        0.99       0.1  
##  3 1228         406      31198655… 1041453           1        1.43       0.15 
##  4 906          319      31198705… 1020156           1        1.5        0.290
##  5 906          319      31198705… 1053875           2        2.78       0.8  
##  6 906          319      31198705… 1060312           1        5.49       0.5  
##  7 906          319      31198705… 1075313           1        1.5        0.290
##  8 1058         381      31198676… 985893            1        1.88       0.21 
##  9 1058         381      31198676… 988791            1        1.5        1.29 
## 10 1058         381      31198676… 9297106           1        2.69       0    
## # … with 1,469,297 more rows, and 4 more variables: coupon_disc <dbl>,
## #   coupon_match_disc <dbl>, week <int>, transaction_timestamp <dttm>
```

``` r
# get the full promotions data set
promotions <- get_promotions()
promotions
## # A tibble: 20,940,529 x 5
##    product_id store_id display_location mailer_location  week
##    <chr>      <chr>    <fct>            <fct>           <int>
##  1 1000050    316      9                0                   1
##  2 1000050    337      3                0                   1
##  3 1000050    441      5                0                   1
##  4 1000092    292      0                A                   1
##  5 1000092    293      0                A                   1
##  6 1000092    295      0                A                   1
##  7 1000092    298      0                A                   1
##  8 1000092    299      0                A                   1
##  9 1000092    304      0                A                   1
## 10 1000092    306      0                A                   1
## # … with 20,940,519 more rows
```

``` r
# a convenience function to get both
c(promotions, transactions) %<-% get_data(which = 'both', verbose = FALSE)
dim(promotions)
## [1] 20940529        5

dim(transactions)
## [1] 1469307      11
```

## Learn more

Learn more about the completejourney data, and the type of insights you
can look for, at
[http://bit.ly/completejourney](https://bradleyboehmke.github.io/completejourney/).

## Source

The Complete Journey data is available at:
<http://www.8451.com/area51/>.
