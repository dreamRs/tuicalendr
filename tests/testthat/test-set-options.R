test_that("set_week_options works", {
  
  cal <- calendar() %>% 
    set_week_options(startDayOfWeek = 1)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$week, "list")
  expect_length(cal$x$options$week, 1)
  
  cal <- calendar() %>% 
    set_week_options(startDayOfWeek = 1) %>% 
    set_week_options(workweek = TRUE)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$week, "list")
  expect_length(cal$x$options$week, 2)
})


test_that("set_month_options works", {
  
  cal <- calendar() %>% 
    set_month_options(startDayOfWeek = 1)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$month, "list")
  expect_length(cal$x$options$month, 1)
  
  cal <- calendar() %>% 
    set_month_options(startDayOfWeek = 1) %>% 
    set_month_options(narrowWeekend = TRUE)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$month, "list")
  expect_length(cal$x$options$month, 2)
  
})



test_that("both month and week works", {
  
  cal <- calendar() %>% 
    set_month_options(startDayOfWeek = 1) %>% 
    set_week_options(startDayOfWeek = 1)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$month, "list")
  expect_length(cal$x$options$month, 1)
  expect_is(cal$x$options$week, "list")
  expect_length(cal$x$options$week, 1)
})

