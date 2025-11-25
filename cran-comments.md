## Changes

This is a maintenance release to address CRAN policy compliance:

* Download functions (`get_data()`, `get_transactions()`, `get_promotions()`)
  now fail gracefully with informative messages when internet resources are
  unavailable (network timeout, GitHub unavailability) instead of throwing
  errors. Functions return NULL on failure with clear user guidance.
* Updated function documentation to reflect the NULL return behavior on failure.
* Added unit test to verify graceful failure behavior.
* Fixed typo in vignette (issue #17).

This addresses the CRAN policy: "Packages which use Internet resources should
fail gracefully with an informative message if the resource is not available."

## Test environments
* local macOS install, R 4.5.1
* win-builder (devel and release)
* R-hub (ubuntu-latest, windows-latest, macos-latest)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

There are currently no downstream dependencies for this package.