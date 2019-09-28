## Changes

This is a resubmission. This versions:

* resolves a bug fix in .Rbuildignore that  wasn't allowing namespacing to the 
  data sets
* adds condition handling to provide informative errors regarding internet 
  connection when trying to download online data sets

## Test environments
* local OS X install, R 3.6.1
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

## Reverse dependencies

There are currently no downstream dependencies for this package.