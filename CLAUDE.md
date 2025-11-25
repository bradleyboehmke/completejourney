# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

This is an R data package providing retail shopping transactions data from the 84.51° Complete Journey 2.0 study. It contains grocery store shopping data for 2,469 households over one year, including transactions, demographics, campaigns, coupons, and product metadata.

## Key Architecture

### Data Distribution Strategy

The package uses a hybrid approach for data distribution due to size constraints:

1. **Built-in datasets** (smaller data): Stored as `.rda` files in `data/` directory
   - `campaigns`, `campaign_descriptions`, `coupons`, `coupon_redemptions`
   - `demographics`, `products`
   - `transactions_sample` (75,000 rows), `promotions_sample` (360,535 rows)

2. **Remote datasets** (large data): Stored as `.rds` files on GitHub, downloaded on demand
   - `transactions` (1.47M rows) - downloaded via `get_transactions()`
   - `promotions` (20.9M rows) - downloaded via `get_promotions()`
   - Both available via `get_data(which = 'both')`

The download mechanism is implemented in `R/utils.R:download_data()` which:
- Checks internet connectivity via `curl::has_internet()`
- Downloads from GitHub using `readRDS(gzcon(url(...)))`
- Shows progress bars using the `progress` package
- Returns single tibble or list of tibbles
- **Fails gracefully**: If downloads fail (timeout, 404, network issues), displays informative message and returns NULL instead of throwing error (CRAN policy compliance)

### Data Processing Pipeline

The `data-raw/prep-data.R` script contains the complete data cleaning pipeline for converting raw 84.51° CSV files into package-ready data. Key transformations include:

- **Transactions**: Date normalization (converting day index to real dates), creating transaction timestamps, standardizing discount fields, filtering to one-year slice (days 285-650)
- **Demographics**: Extensive factor level recoding and household composition inference logic
- **Products**: Department standardization, package size normalization, product category cleaning
- **Promotions**: Week re-indexing, conversion of display/mailer to factor levels
- **Campaigns**: Campaign ID remapping to sequential 1-27 range (see switch_id() function)

## Common Commands

### Package Development

```r
# Install development dependencies
install.packages(c("devtools", "roxygen2", "testthat", "usethis"))

# Load package during development
devtools::load_all()

# Generate documentation from roxygen2 comments
devtools::document()

# Run tests
devtools::test()

# Check package
devtools::check()

# Build package
devtools::build()

# Install from local source
devtools::install()
```

### Testing

```r
# Run all tests
testthat::test_dir("tests/testthat")

# Run specific test file
testthat::test_file("tests/testthat/test_dimensions.R")
```

Tests are located in `tests/testthat/` and use `skip_on_cran()` and `skip_on_ci()` to avoid running dimension checks in CI environments.

### Building Documentation

```r
# Generate pkgdown site
pkgdown::build_site()

# Preview vignettes
devtools::build_vignettes()
```

### Data Regeneration

To rebuild the package datasets from raw source files, run the data processing script:

```r
source("data-raw/prep-data.R")
```

Note: This requires the raw CSV files from 84.51° to be available at the hardcoded path `../../Data sets/Complete_Journey_UV_Version/`.

## Package Structure

### R/ Directory Files

- `completejourney.R`: Package-level documentation
- Individual data documentation files: `campaigns.R`, `coupons.R`, `demographics.R`, `products.R`, `transactions.R`, `promotions.R`, `campaign_descriptions.R`, `coupon_redemptions.R`
- `get_data.R`: Convenience function to download both datasets
- `get_transactions.R`, `get_promotions.R`: Individual download functions
- `utils.R`: Internal helper functions (`download_data()`, `%notin%`, pipe operators)
- `zzz.R`: Package startup messages

### Dependencies

- Core: `dplyr`, `tibble`, `curl`, `progress`, `stringr`, `zeallot`
- Suggests: `lubridate`, `knitr`, `rmarkdown`, `testthat`

### Multi-assignment Pattern

The package re-exports `zeallot::%<-%` to enable unpacking multiple datasets:

```r
c(promotions, transactions) %<-% get_data(which = 'both')
```

## Important Conventions

### ID Variables

All ID columns (e.g., `household_id`, `product_id`, `store_id`, `campaign_id`) are stored as character strings, not integers.

### Date Handling

- Transaction dates use the America/New_York timezone
- Original "day" index (285-650) is converted to real dates starting from 2017-01-01
- Week numbers are re-indexed starting from 1 (original week_no - 40)
- Special case: Daylight saving time on 2017-03-12 handled in timestamp creation
- Christmas Day (2017-12-25) transactions are removed (assumed store closed)

### Discount Fields

All discount fields (`retail_disc`, `coupon_disc`, `coupon_match_disc`) are stored as positive values. Positive retail discounts in raw data are converted to zero.

### .Rbuildignore Entries

The package excludes `data/promotions.rds` and `data/transactions.rds` from the built package since they're too large for CRAN and are downloaded separately.
