pkgs <- c("DPchecker", "EMLeditor", "NPSutils", "QCkit", "EML", "EMLassemblyline")

NPSdataverse_attach <- function() {
  # Create `to_load` which is a character vector of all NPSdataverse
  # packages not loaded in the current R session.
  to_load <- check_loaded()

  # If to_load has length 0, all main packages are loaded.
  # Nothing will be attached.
  if (length(to_load) == 0) {
    return(invisible())
  }

  # Create a line rule with two text labels:
  # "Attaching packages" on the left-hand side and
  # NPSdataverse with the package version on the right-hand side
  load_header <- cli::rule(
    left = cli::style_bold("Attaching packages"),
    right = paste0("NPSdataverse ", package_version("NPSdataverse"))
  )

  # Return a character string containing the package version for each of NPSdataverse's constituents
  versions <- vapply(to_load, package_version, character(1))

  packages <- paste0(
    cli::col_green(cli::symbol$tick), " ", cli::col_blue(format(to_load)), " ",
    cli::ansi_align(versions, max(cli::ansi_nchar(versions)))
  )

  # Format for two columns
  # if there is an odd number of packages, add ""
  if (length(packages) %% 2 == 1) {
    packages <- append(packages, "")
  }
  # Divide the packages into column 1 and 2
  col1 <- seq_len(length(packages) / 2)
  # paste the packages in column one with a space and those not in column 1
  info <- paste0(packages[col1], "     ", packages[-col1])

  # display the message!
  packageStartupMessage(load_header)
  packageStartupMessage(paste(info, collapse = "\n"))

  # Load the constituent packages!
  # character.only = TRUE must be used in order to
  # supply character strings to `library()`
  suppressPackageStartupMessages(
    lapply(to_load, library, character.only = TRUE)
  )

  # Thanks for playing
  invisible(to_load)
}

#' Detach all loaded packages
#'
#' @return invisilble
#' @export
#'
#' @examples
#' \dontrun{
#' detach_NPSdataverse()
#' }
detach_NPSdataverse <- function() {
  pak <- paste0("package:", c(pkgs, "NPSdataverse"))
  lapply(pak[pak %in% search()], detach, character.only = TRUE)
  invisible()
}

#' List all packages imported by NPSdataverse
#'
#' @export
#'
#' @examples
#' NPSdataverse_packages()
NPSdataverse_packages <- function() {
  # get all imports from NPSdataverse's package description file
  raw <- utils::packageDescription("NPSdataverse")$Imports
  # return a character vector of all the imports
  imports <- strsplit(raw, ",")[[1]]
  # "^\\s+" matches white space at the beginning of a character string
  # "\\s+$ matches white space at the end of a character string
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  # for each import, take only the first complete word (i.e. the package name)
  names <- vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))

  return(names)
}

#' Check internet connectivity
#'
#' @description Checks whether the system can ping github.com. Adapted from:https://stackoverflow.com/questions/5076593/how-to-determine-if-you-have-an-internet-connection-in-r

#' @param site string defaults to https://github.com
#'
#' @return logical
#' @export
#'
#' @examples
#' is_online()
is_online <- function(site = "https://github.com/") {
  tryCatch(
    {
      readLines(site, n = 1)
      TRUE
    },
    warning = function(w) invokeRestart("muffleWarning"),
    error = function(e) FALSE
  )
}
