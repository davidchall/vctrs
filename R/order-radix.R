#' Order and sort vectors
#'
#' @description
#' `vec_order()` computes the order of `x`. For data frames, the order is
#' computed along the rows by computing the order of the first column and
#' using subsequent columns to break ties.
#'
#' `vec_sort()` sorts `x` by computing its order and using `vec_slice()` to
#' rearrange.
#'
#' @details
#' Character vectors are ordered in the C-locale. This is different from
#' `base::order()`, which respects `base::Sys.setlocale()`. Sorting in a
#' consistent locale can produce more reproducible results between different
#' sessions and platforms, however, the results of sorting in the C-locale
#' can be surprising. For example, capital letters sort before lower case
#' letters. Sorting `c("b", "C", "a")` with `vec_sort()` will return
#' `c("C", "a", "b")`, but with `base::order()` will return `c("a", "b", "C")`
#' unless `base::order(method = "radix")` is explicitly set, which also uses
#' the C-locale. While sorting with the C-locale can be useful for
#' algorithmic efficiency, in many real world uses it can be the cause of
#' data analysis mistakes.
#'
#' Character vectors are always translated to UTF-8 before ordering.
#'
#' @param x A vector
#' @param direction Direction to sort in.
#'   - A single `"asc"` or `"desc"` for ascending or descending order
#'     respectively.
#'   - For data frames, a length `1` or `ncol(x)` character vector containing
#'     only `"asc"` or `"desc"`, specifying the direction for each column.
#' @param na_value Treatment of `NA` values. `NaN` values are treated as
#'   equivalent to `NA` values.
#'   - A single `"largest"` or `"smallest"` for treating `NA` values as the
#'     largest or smallest values respectively.
#'   - For data frames, a length `1` or `ncol(x)` character vector containing
#'     only `"largest"` or `"smallest"`, specifying how `NA`s should be treated
#'     in each column.
#' @return
#' * `vec_order()` an integer vector the same size as `x`.
#' * `vec_sort()` a vector with the same size and type as `x`.
#'
#' @section Dependencies of `vec_order()`:
#' * [vec_proxy_order()]
#'
#' @section Dependencies of `vec_sort()`:
#' * [vec_order()]
#' * [vec_slice()]
#' @examples
#' x <- round(sample(runif(5), 9, replace = TRUE), 3)
#' x <- c(x, NA)
#'
#' vec_order(x)
#' vec_sort(x)
#' vec_sort(x, "desc")
#'
#' # Can also handle data frames
#' df <- data.frame(g = sample(2, 10, replace = TRUE), x = x)
#' vec_order(df)
#' vec_sort(df)
#' vec_sort(df, "desc")
#'
#' # For data frames, `direction` and `na_value` are allowed to be vectors
#' # with length equal to the number of columns in the data frame
#' vec_sort(
#'   df,
#'   direction = c("desc", "asc"),
#'   na_value = c("largest", "smallest")
#' )
#' @noRd
vec_order_radix <- function(x, direction = "asc", na_value = "largest") {
  .Call(vctrs_order, x, direction, na_value)
}

#' Identify ordered groups
#'
#' @description
#' \Sexpr[results=rd, stage=render]{vctrs:::lifecycle("experimental")}
#'
#' `vec_order_locs()` returns a data frame containing a `key` column with
#' sorted unique groups, and a `loc` column with the locations of each
#' group in `x`. It is similar to [vec_group_loc()], except the groups are
#' returned sorted rather than by first appearance.
#'
#' @inheritParams vec_order
#'
#' @return
#' A two column data frame with size equal to `vec_size(vec_unique(x))`.
#'   * A `key` column of type `vec_ptype(x)`.
#'   * A `loc` column of type list, with elements of type integer.
#'
#' @section Dependencies of `vec_order_locs()`:
#' * [vec_proxy_order()]
#'
#' @examples
#' df <- data.frame(
#'   g = sample(2, 10, replace = TRUE),
#'   x = c(NA, sample(5, 9, replace = TRUE))
#' )
#'
#' # `vec_order_locs()` is similar to `vec_group_loc()`, except keys are
#' # returned ordered rather than by first appearance.
#' vec_order_locs(df)
#'
#' vec_group_loc(df)
#' @noRd
vec_order_locs <- function(x, direction = "asc", na_value = "largest") {
  .Call(vctrs_order_locs, x, direction, na_value)
}
