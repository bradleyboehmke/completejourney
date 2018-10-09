
<!-- README.md is generated from README.Rmd. Please edit that file -->

# completejourney

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

## Overview

An R data package of the Complete Journey Study provided by
[84.51](http://www.8451.com). The data represents retail shopping
transactions over two years from a group of 2,500 households who are
frequent shoppers at a retailer. It contains all of each household’s
purchases, not just those from a limited number of categories. For
certain households, demographic information as well as direct marketing
contact history are included. The package comes with the following
datasets:

  - `transaction_data`: products purchased by households
  - `product`: product metadata (brand, description, etc.)
  - `hh_demographic`: household demographic data (age, income, family
    size, etc.)
  - `campaign_table`: campaigns received by each household
  - `campaign_desc`: campaign metadata (length of time active)
  - `coupon`: coupon metadata (UPC code, campaign, etc.)
  - `coupon_redempt`: coupon redemptions (household, day, UPC code,
    campaign)
  - `causal_data`: product placement in mailer and in-store
    corresponding to campaigns

## Installation

You can install `completejourney` from github with:

``` r
# install.packages("devtools")
devtools::install_github("bradleyboehmke/completejourney")
```

## Source

The Complete Journey data is available at:
<http://www.8451.com/area51/>.
