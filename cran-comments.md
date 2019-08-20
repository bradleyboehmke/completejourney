## Resubmission

This is a resubmission addressing Swetlana Herbrandt's comment: "Thanks, please 
replace `\dontrun{}` by `\donttest{}` in your Rd-files (there is not need to 
frighten users with the # Not run statement in your examples)."

Reply:
* For all the datasets I have replaced `\dontrun{}` with `\donttest{}`.
* For the three `get_xxx()` functions I left `\dontrun{}` simply becuase they
require internet connections for the examples to work.

## Test environments
* local OS X install, R 3.6.1
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

## Reverse dependencies

This is a new release, so there are no reverse dependencies.

