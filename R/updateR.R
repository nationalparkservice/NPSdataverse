#' Update info for git repos in NPSdataverse
#'
#' @description `.update_git_repos()` determines which of the NPSdataverse packages from github need to be updated and provides instructions on how to do so.
#'
#' @return dataframe
#' @keywords internal
#'
.update_git_repos <- function() {
  git_pkgs <- c(
    "NPSdataverse",
    "QCkit",
    "EMLeditor",
    "DPchecker",
    "NPSutils",
    "EMLassemblyline"
  )

  pkg_update <- remotes::package_deps(git_pkgs, dependencies = c(
    "Imports",
    "Remotes",
    "Suggests"
  ))

  if (any(pkg_update$diff < 0)) {
    old_pkgs <- NULL
    old_users <- NULL
    for (i in seq_along(pkg_update$diff)) {
      if (pkg_update$diff[i] < 0) {
        old_pkgs <- append(old_pkgs, pkg_update$package[i])
        old_users <- append(old_users, pkg_update$remote[[i]]$username)
      }
    }
    load_header <- cli::rule(
      left = cli::pluralize(
        "The following {cli::qty(length(old_pkgs))}package{?s} {?is/are} out of date:\n"
      )
    )
    msg(load_header)
    .print_cust_package_deps(pkg_update)
    cli::cat_line()
    cli::cli_text(
      "{.strong To update {cli::qty(length(old_pkgs))}th{?is/ese} {cli::qty(length(old_pkgs))}package{?s}, please run:\n}"
    )
    cli::cat_line("detach_NPSdataverse()")
    cli::cat_line("devtools::install_github(\"", old_users, "/", old_pkgs, "\")")
    cli::cat_line("\nClose R and Rstudio. Open a new R session and reload the NPSdataverse.")
    cli::cat_line()
  } else {
    load_header <- cli::rule(
      left = cli::pluralize(
        "All NPSdataverse packages are up to date."
      )
    )
    msg(load_header)
    cli::cat_line()
  }
}

#' Custom print function for github repos to update
#'
#' @description formats print table for custom printing package dependencies in need to updating. `Derived from remotes:::print.package_deps()`.
#'
#' @param x dataframe. Output from NPSvers_update.
#' @param show_ok logical.
#' @param ...
#'
#' @noRd
#' @return printed text to console
#' @keywords internal
#'
.print_cust_package_deps <- function(x, show_ok = FALSE, ...) {
  class(x) <- "data.frame"
  x$remote <- lapply(x$remote, format)
  ahead <- x$diff > 0L
  behind <- x$diff < 0L
  same_ver <- x$diff == 0L
  x$diff <- NULL
  x[] <- lapply(x, remotes:::format_str, width = 12)
  if (any(behind)) {
    # cat("Needs update -----------------------------\n")
    print(x[behind, , drop = FALSE], row.names = FALSE, right = FALSE)
  }
  if (any(ahead)) {
    cat("Not on CRAN ----------------------------\n")
    print(x[ahead, , drop = FALSE], row.names = FALSE, right = FALSE)
  }
  if (show_ok && any(same_ver)) {
    cat("OK ---------------------------------------\n")
    print(x[same_ver, , drop = FALSE],
      row.names = FALSE,
      right = FALSE
    )
  }
}
