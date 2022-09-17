
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cli.menu

<!-- badges: start -->

[![](https://img.shields.io/badge/devel%20version-0.1.0-blue.svg)](https://github.com/markheckmann/cli.menu)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

A command line interface multi select input dialog. Similar to
`utils::menu()` but allowing multi select.

## Installation

You can install the development version of menu like so:

``` r
remotes::install_github("markheckmann/cli.menu")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(cli.menu)
x <- c("One", "Two", "Three")
cli_menu(x)
```
