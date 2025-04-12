#' Update info for git repos in NPSdataverse
#'
#' @description `.update_git_repos()` determines which of the NPSdataverse packages from github need to be updated and provides instructions on how to do so.
#'
#' @return dataframe
#' @keywords internal
#'
.update_git_repos <- function() {
  git_pkgs <- tibble::tibble(
    package = c(
      "QCkit",
      "EMLeditor",
      "DPchecker",
      "NPSutils",
      "EMLassemblyline",
      "NPSdataverse"
    ),
    repo = c(
      "nationalparkservice",
      "nationalparkservice",
      "nationalparkservice",
      "nationalparkservice",
      "EDIorg",
      "nationalparkservice"),
    branch = c(
      "master",
      "main",
      "main",
      "master",
      "main",
      "main"
    )
  )

  git_pkgs$local_version <- lapply(git_pkgs$package, packageVersion)
  git_pkgs$latest_version <- mapply(function(x, y, z) .latest_github_version(repo = x, repo_owner = y, branch = z), git_pkgs$package, git_pkgs$repo, git_pkgs$branch, USE.NAMES = FALSE, SIMPLIFY = FALSE)
  git_pkgs$behind <- mapply(function(x, y) x < y, git_pkgs$local_version, git_pkgs$latest_version)
  git_pkgs$ahead <- mapply(function(x, y) x > y, git_pkgs$local_version, git_pkgs$latest_version)
  git_pkgs$local_version <- sapply(git_pkgs$local_version, as.character)
  git_pkgs$latest_version <- sapply(git_pkgs$latest_version, as.character)

  if (any(git_pkgs$behind)) {
    old_pkgs <- git_pkgs[git_pkgs$behind, ]

    load_header <- cli::rule(
      left = cli::pluralize(
        "The following {cli::qty(length(old_pkgs$package))}package{?s} {?is/are} out of date:\n"
      )
    )
    packageStartupMessage(load_header)
    packageStartupMessage(.print_cust_package_deps(old_pkgs))
    cli::cat_line()
    cli::cli_text(
      "{.strong To update {cli::qty(length(old_pkgs$package))}th{?is/ese} {cli::qty(length(old_pkgs$package))}package{?s}, please run:\n}"
    )
    cli::cat_line("detach_NPSdataverse()")
    cli::cat_line("devtools::install_github(\"", old_pkgs$repo, "/", old_pkgs$package, "\")")
    cli::cat_line("\nClose R and Rstudio. Open a new R session and reload the NPSdataverse.")
    cli::cat_line()
  } else {
    load_header <- cli::rule(
      left = cli::pluralize(
        "All NPSdataverse packages are up to date."
      )
    )
    packageStartupMessage(load_header)
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
.print_cust_package_deps <- function(pkgs) {

  pkg_names <- paste0(cli::col_yellow(cli::symbol$warning), " ", cli::col_blue(pkgs$package))
  vers <- paste0("(", pkgs$local_version, " ", cli::symbol$arrow_right, " ", pkgs$latest_version, ")")

  packages <- paste(
    cli::ansi_align(pkg_names, max(cli::ansi_nchar(pkg_names))),
    vers, collapse = "\n")

  return(packages)
}

#' Get the latest version of an R package that is on GitHub
#'
#' @param repo Name of the GitHub repository (e.g. "DPchecker")
#' @param repo_owner Owner of the GitHub repository (e.g. "nationalparkservice")
#' @param branch Branch to use (defaults to "main")
#' @param release_only If TRUE, only looks at GitHub releases. If FALSE (default), looks at the version number in the DESCRIPTION file.
#'
#' @returns A package version number
#' @keywords internal
#'
.latest_github_version <- function(repo, repo_owner, branch = "main", release_only = FALSE) {
  if (!release_only) {
    # Get version number from DESCRIPTION file on GitHub
    description_url <- paste("https://raw.githubusercontent.com", repo_owner, repo, branch, "DESCRIPTION", sep = "/")
    description <- readr::read_lines(description_url)
    version_line <- grep("^Version:\\s*", description)
    version_number <- stringr::str_remove(description[version_line], "^Version:\\s*")
  }
  else {
    # Get version number of latest release on GitHub
    releases_url <- paste("https://api.github.com/repos", repo_owner, repo, "releases?per_page=1", sep = "/")
    latest_release <- gh::gh(releases_url)
    version_number <- latest_release[[1]]$tag_name
  }

  version_number <- stringr::str_remove_all(version_number, "[a-zA-Z]")
  version_number <- as.package_version(version_number)

  return(version_number)
}
