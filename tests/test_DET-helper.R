library(testthat)
context("DET helper functions")
source("../DET_helpers.R")

##auto_test(code_path = "~/Dropbox/IOW/R-functions/DET_helpers/", test_path = "~/Dropbox/IOW/R-functions/DET_helpers/tests/")

test_that("DET.slice.volume.ccm() returns right slice volume as calculated manually",{
  # when providing only slice width:
  expect_equal(DET.slice.volume.ccm(slice.width.mm = 5), 0.1)
  # when providing standard slice geometry:
  expect_equal(DET.slice.volume.ccm(slice.width.mm = 5, gel.thickness.mm = 1, DET.window.width.mm = 20), 0.1)
  # when providing different slice geometry:
  expect_equal(DET.slice.volume.ccm(slice.width.mm = 5, gel.thickness.mm = 2, DET.window.width.mm = 20), 0.2)
  expect_equal(DET.slice.volume.ccm(slice.width.mm = 5, gel.thickness.mm = 1, DET.window.width.mm = 10), 0.05)
})

test_that("DET.slice.amount.uM() returns right amount of substance in given gel slice volume as calculated manually",{
  # when providing slice volume and ambient conc:
  expect_equal(DET.slice.amount.uM(V.slice.ccm = 0.1, # 5mm slice of 2cm wide and 1mm thick gel
                                   c.ambient.uM = c(10, 1000, 1000000)), # PW concentrations of 10µM, 1mM and 1M
               c(0.001, 0.1, 100)) 
  # when providing slice geometry (other than standard) and ambient conc:
  expect_equal(DET.slice.amount.uM(c.ambient.uM = 1000, slice.width.mm = 5,
                                   gel.thickness.mm = 5,
                                   DET.window.width.mm = 20), 0.5)
})

test_that("DET.extract.conc.uM() returns right concentration of the resulting extract as calculated manually",{
  # when providing minimal set of argumments:
  expect_equal(DET.extract.conc.uM(V.slice.ccm = 0.1, # 5mm slice of 2cm wide and 1mm thick gel
                                   c.ambient.uM = 10, # PW concentrations of 10µM, 1mM and 1M
                                   V.extraction.uL = 900), 1) #1000µL MilliQ or 2%HNO3 for extraction
  # when providing slice geometry (handed to the other functions):
  expect_equal(DET.extract.conc.uM(slice.width.mm = 5, 
                                   gel.thickness.mm = 1.5,
                                   DET.window.width.mm = 200,
                                   c.ambient.uM = 10, 
                                   V.extraction.uL = 1000), 6) #1000µL MilliQ or 2%HNO3 for extraction
})

test_that("functions throw errors when called without arguments", {
  expect_error(DET.slice.volume.ccm())
  expect_error(DET.slice.amount.uM())
  expect_error(DET.extract.conc.uM())
})