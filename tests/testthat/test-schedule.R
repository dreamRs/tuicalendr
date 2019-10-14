test_that("add_schedule works", {
  
  schedule <- calendar() %>% 
    add_schedule(start = 1, end = 2, title = "Title")
  
  expect_is(schedule, "calendar")
  expect_is(schedule$x$schedules, "list")
  expect_length(schedule$x$schedules, 1)
})

test_that("add_schedule_df works", {
  
  n <- sample(5:15, 1)
  date_start <- sample(
    seq(from = as.POSIXct(Sys.Date()-14), by = "1 hour", length.out = 24*7*4),
    n, TRUE
  )
  date_end <- date_start + sample(1:25, n, TRUE) * 3600
  df <- data.frame(
    id = 1:n,
    calendarId = as.character(sample(1:3, n, TRUE)),
    title = LETTERS[1:n],
    body = paste("Body schedule", letters[1:n]),
    start = format(date_start, format = "%Y-%m-%dT%H:%00:%00"),
    end = format(date_end, format = "%Y-%m-%dT%H:%00:%00"),
    category = sample(c("allday", "time", "task"), n, TRUE),
    stringsAsFactors = FALSE
  )
  
  schedule <- calendar() %>% 
    add_schedule_df(df = df)
  
  expect_is(schedule, "calendar")
  expect_is(schedule$x$schedules, "list")
  expect_length(schedule$x$schedules, n)
})

