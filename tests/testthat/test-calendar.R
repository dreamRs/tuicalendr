test_that("calendar works", {
  
  cal <- calendar()
  
  expect_is(cal, "htmlwidget")
})

test_that("calendar with nav works", {
  
  cal <- calendar()
  expect_null(cal$dependencies)
  
  cal <- calendar(useNav = TRUE)
  expect_false(is.null(cal$dependencies))
})

test_that("calendar_html works", {
  
  calhtml <- calendar_html(id = "id", style = "style", class = "class")
  
  expect_is(calhtml, "shiny.tag.list")
})

