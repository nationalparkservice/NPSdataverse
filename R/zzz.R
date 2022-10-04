.onAttach <- function(...) {
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
