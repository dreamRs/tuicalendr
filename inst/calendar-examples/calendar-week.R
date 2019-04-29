
#  ------------------------------------------------------------------------
#
# Title : Calendar examples : week view
#    By : Victor
#  Date : 2019-04-23
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(tuicalendr)



# Datas -------------------------------------------------------------------

calendarProps <- data.frame(
  id = c("1", "2", "3"), 
  name = c("TODO", "Meetings", "Tasks"),
  color = c("#FFF", "#FFF", "#000"), 
  bgColor = c("#E41A1C", "#377EB8", "#4DAF4A"),
  borderColor = c("#a90000", "#005288", "#0a7f1c")
)


date_start <- sample(
  seq(from = as.POSIXct(Sys.Date()-2), by = "1 hour", length.out = 24*7),
  10, TRUE
)
date_end <- date_start + sample(1:10, 10, TRUE) * 3600
schedules <- data.frame(
  id = 1:10, 
  calendarId = as.character(sample(1:3, 10, TRUE)),
  title = LETTERS[1:10],
  body = paste("Body schedule", letters[1:10]),
  start = format(date_start, format = "%Y-%m-%dT%H:%00:%00"),
  end = format(date_end, format = "%Y-%m-%dT%H:%00:%00"),
  category = sample(c("allday", "time", "task"), 10, TRUE),
  stringsAsFactors = FALSE
)




# Calendar ----------------------------------------------------------------

calendar(defaultView = "week", taskView = TRUE, scheduleView = c("time", "allday")) %>% 
  set_calendars_props_df(df = calendarProps) %>% 
  add_schedule_df(df = schedules)
