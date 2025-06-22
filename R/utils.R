# Format the package version to indicate development versions when printed on
# the command line
package_version <- function(x) {
  # packageVersion returns an object with class 'package_version' and 'numeric_version'
  # unclass removes those and it becomes a numeric
  version <- unclass(utils::packageVersion(x))[[1]]

  # if the length of the numeric version vector is > 3,
  # as happens with development packages, coerce those
  # dev version numbers to red
  if (length(version) > 3) {
    version[4:length(version)] <- cli::col_red(as.character(version[4:length(version)]))
  }

  # concatenate the result
  paste0(version, collapse = ".")
}

# Check which of the main NPSdataverse packages
# are currently loaded and return a list of those that are NOT loaded
# The search() function  returns a character vector containing packages
# attached to the current R session.
check_loaded <- function() {
  paks <- paste0("package:", pkgs)
  pkgs[!paks %in% search()]
}

# Is a package attached?
is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
