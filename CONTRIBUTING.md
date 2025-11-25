# Contributing to completejourney

Thank you for your interest in contributing to the completejourney package! This document provides guidelines and instructions for contributing to the project.

## Development Setup

### Prerequisites

Install the required development packages:

```r
install.packages(c("devtools", "roxygen2", "testthat", "usethis", "pkgdown", "rhub"))
```

### Getting Started

1. Fork and clone the repository
2. Load the package during development:

```r
devtools::load_all()
```

## Making Changes

### Code Style

- Follow the [tidyverse style guide](https://style.tidyverse.org/)
- Use meaningful variable and function names
- Document all exported functions using roxygen2 comments

### Documentation

All exported functions must be documented using roxygen2 comments. Add special comment blocks above your function:

```r
#' Function title (one line)
#'
#' Detailed description of what the function does.
#' Can span multiple lines.
#'
#' @param param1 Description of first parameter
#' @param param2 Description of second parameter
#'
#' @return Description of what the function returns
#'
#' @examples
#' my_function(param1 = "value", param2 = 10)
#'
#' @export
my_function <- function(param1, param2) {
  # Function code here
}
```

After making changes to function documentation, regenerate the `.Rd` files:

```r
# Generate documentation from roxygen2 comments
devtools::document()
```

Preview documentation for a specific function:

```r
# Preview help file
?my_function
```

Update the pkgdown site to see documentation changes on the website:

```r
# Build the pkgdown website
pkgdown::build_site()
```

## Testing

### Running Tests

Run all tests locally:

```r
# Run all tests (recommended - uses devtools)
devtools::test()

# Alternative: run all tests using testthat directly
testthat::test_package("completejourney")

# Run specific test file
testthat::test_file("tests/testthat/test_downloads.R")
```

**Note:** `devtools::test()` is the recommended approach as it automatically loads the package and handles the testing environment properly. Use `testthat` functions directly only when you need more control over the testing process.

### Writing Tests

- Add tests for new functionality in `tests/testthat/`
- Use `skip_on_cran()` for tests that require internet connectivity
- Use `skip_on_ci()` for tests that shouldn't run in continuous integration
- Follow existing test patterns in the package
- Test files should be named `test_*.R`
- Each test should use descriptive names in `test_that()` blocks

## Package Checks

### Local Checks

Before submitting a pull request, run a full package check:

```r
# Comprehensive local check (recommended)
devtools::check()

# For CRAN submission: use --as-cran flag for stricter checks
devtools::check(args = "--as-cran")
```

This should return: **0 errors ✓ | 0 warnings ✓ | 0 notes ✓**

**When to use `--as-cran`:**
- Use `devtools::check()` for regular development and pull requests
- Use `devtools::check(args = "--as-cran")` when preparing for CRAN submission (performs additional checks like CRAN does)

### Quick Checks During Development

For faster iteration during development:

```r
# Fast check (skips some time-consuming checks)
devtools::check(document = FALSE, vignettes = FALSE)

# Even faster: just check for syntax errors and basic issues
devtools::load_all()
devtools::test()
```

### Platform-Specific Checks

Before major releases or CRAN submissions, test on multiple platforms:

#### Windows Builder

```r
# Check on Windows (R-devel)
devtools::check_win_devel()

# Check on Windows (R-release)
devtools::check_win_release()

# Check on Windows (R-oldrelease)
devtools::check_win_oldrelease()
```

#### R-hub

```r
# Automated CRAN platform checks
rhub::check_for_cran()

# Or specify specific platforms
rhub::check(platform = c(
  "ubuntu-gcc-release",
  "windows-x86_64-devel",
  "macos-highsierra-release-cran"
))
```

You'll receive email notifications with the results.

## CRAN Submission Workflow

For maintainers preparing a CRAN submission:

```r
# 1. Update version number in DESCRIPTION
usethis::use_version()

# 2. Update NEWS.md with changes

# 3. Generate documentation
devtools::document()

# 4. Build pkgdown site
pkgdown::build_site()

# 5. Run local check with CRAN settings
devtools::check(args = "--as-cran")

# 6. Check on win-builder
devtools::check_win_devel()
devtools::check_win_release()

# 7. Check on R-hub
rhub::check_for_cran()

# 8. Update cran-comments.md with test results

# 9. Submit to CRAN
devtools::release()
```

## Data Pipeline

### Regenerating Package Data

The package datasets are generated from raw CSV files. To rebuild them:

```r
source("data-raw/prep-data.R")
```

**Note:** This requires the raw CSV files from 84.51° at the hardcoded path `../../Data sets/Complete_Journey_UV_Version/`

### Data Distribution Strategy

- **Small datasets** are stored as `.rda` files in `data/` and bundled with the package
- **Large datasets** (transactions, promotions) are stored as `.rds` files on GitHub and downloaded on demand via `get_transactions()`, `get_promotions()`, and `get_data()`

## Building the Package

```r
# Build source package
devtools::build()

# Install from local source
devtools::install()
```

## Pull Request Process

1. Create a new branch for your changes
2. Make your changes and add tests
3. Run `devtools::check()` and ensure it passes
4. Update documentation if needed
5. Submit a pull request with a clear description of changes

## Questions or Issues?

If you have questions or encounter issues:

- Check existing [GitHub issues](https://github.com/bradleyboehmke/completejourney/issues)
- Open a new issue with a reproducible example
- For general questions, consider posting on [Stack Overflow](https://stackoverflow.com/) with the `r` and `completejourney` tags

## Code of Conduct

Please be respectful and constructive in all interactions with the project and community.
