test_that("bttn_options works", {
  
  opts <- bttn_options()
  
  expect_is(opts, "list")
  expect_length(opts, 4)
  
  opts <- bttn_options(bg = "#FAFAFA", color = "#FFF")
  
  expect_is(opts, "list")
  expect_length(opts, 6)
})
