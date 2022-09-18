

#' Interactive multi-select menu for command line
#'
#' @param choices A vector with items to choose from.
#' @param prompt_1,prompt_2 User prompts before and after selection list.
#' @param all_opt,none_opt Not yet implemented.
#' @export
#' @examples
#' if (interactive()) {
#'   x <- c("One", "Two", "Three")
#'   cli_menu(x)
#' }
cli_menu <- function(choices, prompt_1 = "Please select from list:", prompt_2 = "Your selection > ", all_opt = FALSE, none_opt = FALSE) {
  if (!rlang::is_interactive()) {
    cli_abort("User input required, but session is not interactive.")
  }

  cli({
    cli_text(prompt_1)
    cli_text("")
    cli_ol(choices)
    cli_text("")
    cli_alert_info("Enter as single integers (e.g. \033[34m3,4,5\033[39m), or range (e.g. \033[34m3-5\033[39m) or combination of both.")
  })

  n <- readline(prompt = prompt_2)
  nc <- length(choices)
  # repeat {
  ind <- collect_integers(n)
  # challenge_values(ind, choices)
  ind
  # }
}


#' Extract ranges
#'
#' Integers seperated by `-` or `:` are interpreted as a range.
#'
#' @param x A string.
#' @keywords internal
#'
get_ranges <- function(x) {
  stringr::str_extract_all(x, "[0-9]+ *(-|:) *[0-9]+") |>
    unlist()
}


#' Convert range string to numeric vector
#'
#' @param x A string.
#' @keywords internal
#'
range_to_numeric_vector <- function(x) {
  x |>
    stringr::str_replace("-", ":") |>
    rlang::parse_expr() |>
    base::eval()
}


#' Remove ranges from string
#'
#' Remove all parts which are interpretetd as a range from string.
#'
#' @param x A string.
#' @keywords internal
#'
remove_ranges <- function(x) {
  str_remove_all(x, "[0-9]+ *(-|:) *[0-9]+")
}


get_integers <- function(x) {
  str_extract_all(x, "[0-9]+") |>
    unlist() |>
    as.numeric() |>
    as.list()
}


#' Collect integers from string
#'
#' Parses a string and extracts all integers including range-like expressions. Integers can be separated by
#' any character. Integers seperated by `-` or `:` are interpreted as a range.
#'
#' @param x A string.
#' @keywords internal
#' @export
#' @examples
#'
#' # single integers
#' x <- "1 2 3"
#' collect_integers(x)
#'
#' x <- "1, 2, 3"
#' collect_integers(x)
#'
#' # use ranges
#' x <- "1-3"
#' collect_integers(x)
#'
#' x <- "1:3, 5:6"
#' collect_integers(x)
#'
#' # mix integers and ranges
#' x <- "1:3, 4, 7:8"
#' collect_integers(x)
#'
#' # Parser handles all kinds of less structured scenarios
#'
#' x <- " 3, 4, 5-7,10, 11- 14, 20 :22"
#' collect_integers(x)
#'
#' x <- "1 2, 4;5 hello world || 6 A11A"
#' collect_integers(x)
#'
#' x <- "A1,5;;;6-  8H11:  15"
#' collect_integers(x)
#'
collect_integers <- function(x) {
  range_exprs <- get_ranges(x)
  ranges_list <- lapply(range_exprs, range_to_numeric_vector)
  x_no_ranges <- remove_ranges(x)
  integers_list <- get_integers(x_no_ranges)
  ii <- unlist(c(ranges_list, integers_list))
  ii |>
    unique() |>
    sort()
}


# Check input values
challenge_values <- function(x, choices) {
  ii <- seq_along(choices)
  all_vals <- all(x %in% ii)
  if (all_vals) {
    return(TRUE)
  } else {
    FALSE
  }
  # outside_range <- setdiff(x, choices)
}
