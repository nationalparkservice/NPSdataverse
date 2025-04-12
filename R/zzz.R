.onAttach <- function(...) {
  # if internet access is available, check for updated packages:
  # check for github packages that need updating

  if (is_online()) {
    if (interactive()) {
      .update_git_repos()
    }
  } else {
    packageStartupMessage("Warning: You are offline. Cannot check for package updates.\n")
  }

  # See if any packages are needed
  needed <- pkgs[!is_attached(pkgs)]

  # If no packages are needed, return
  if (length(needed) == 0) {
    return()
    # Otherwise, attach any needed packages
  } else {
    NPSdataverse_attach()
  }
}
