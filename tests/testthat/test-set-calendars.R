test_that("set_calendars_props works", {
  
  cal <- calendar() %>% 
    set_calendars_props(id = 1, name = "Cal", color = "#000", bgColor = "#FFF")
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$calendars, "list")
  expect_length(cal$x$options$calendars, 1)
})


test_that("add_schedule_df works", {
  
  calendarProps <- data.frame(
    id = c("1", "2", "3"),
    name = c("TODO", "Meetings", "Tasks"),
    color = c("#FFF", "#FFF", "#000"),
    bgColor = c("#E41A1C", "#377EB8", "#4DAF4A"),
    borderColor = c("#a90000", "#005288", "#0a7f1c")
  )
  
  cal <- calendar() %>% 
    set_calendars_props_df(df = calendarProps)
  
  expect_is(cal, "calendar")
  expect_is(cal$x$options$calendars, "list")
  expect_length(cal$x$options$calendars, nrow(calendarProps))
})
