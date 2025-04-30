test_that("NPSdataverse_attach and detach_NPSdataverse work", {
  NPSdataverse::detach_NPSdataverse()
  loaded <- suppressMessages(NPSdataverse:::NPSdataverse_attach())
  expect_setequal(loaded, NPSdataverse:::pkgs)
})

test_that("NPSdataverse_attach only loads packages that aren't already attached", {
  NPSdataverse:::NPSdataverse_attach()
  detach("package:DPchecker")
  detach("package:EML")
  loaded <- suppressMessages(NPSdataverse:::NPSdataverse_attach())
  expect_setequal(loaded, c("DPchecker", "EML"))
})
