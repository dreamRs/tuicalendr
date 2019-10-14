test_that("set_events works", {
  
  events <- calendar() %>% 
    set_events(
      clickSchedule = JS("function(event) {alert(event.schedule.id);}")
    )
  
  expect_is(events, "calendar")
  expect_length(events$x$events, 1)
  expect_error(set_events(list()))
})
