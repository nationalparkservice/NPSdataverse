test_that("NPSdataverse_package returns character vector of imports", {
  pkg_list <- NPSdataverse_packages()
  expect_true(all(NPSdataverse:::pkgs %in% pkg_list, na.rm = TRUE))
})
