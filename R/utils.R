
text_col <- function(x) {

  # If RStudio API is not available and/or does not have the getThemeInfo
  # button, exit function leaving default color of black
  if (!rstudioapi::isAvailable() || !rstudioapi::hasFun("getThemeInfo")) {
    return(x)
  }

  # Get theme information for RStudio
  theme <- rstudioapi::getThemeInfo()

  # If it's a dark theme, make the text color white; otherwise black.
  if (isTRUE(theme$dark)) crayon::white(x) else crayon::black(x)

}

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
    version[4:length(version)] <- crayon::red(as.character(version[4:length(version)]))
  }

  # concatenate the result
  paste0(version, collapse = ".")

}

# Create a message function for start-up that dynamically changes text color
msg <- function(...) {
  packageStartupMessage(text_col(...))
}


# Check which of the main NPSdataverse packages
# are currently loaded
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


