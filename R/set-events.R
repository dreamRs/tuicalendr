
#' @title Set custom JavaScript events
#' 
#' @description Currently only works in Shiny applications.
#'
#' @param cal A \code{calendar} htmlwidget object.
#' @param afterRenderSchedule Fire this event by every single schedule after rendering whole calendar.
#' @param beforeCreateSchedule Fire this event when select time period in daily, weekly, monthly.
#' @param beforeDeleteSchedule Fire this event when delete a schedule.
#' @param beforeUpdateSchedule Fire this event when drag a schedule to change time in daily, weekly, monthly.
#' @param clickDayname Fire this event when click a day name in weekly.
#' @param clickMorecalendar Fire this event when click a schedule.
#' @param clickSchedule Fire this event when click a schedule.
#' @param clickTimezonesCollapseBtncalendar Fire this event by clicking timezones collapse button.
#' 
#' @note All arguments must be JavaScript function with \code{\link[htmlwidgets]{JS}}.
#'
#' @return A \code{calendar} htmlwidget object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   
#'   library(shiny)
#'   
#'   calendarProps <- data.frame(
#'     id = c("1", "2", "3"), 
#'     name = c("TODO", "Meetings", "Tasks"),
#'     color = c("#FFF", "#FFF", "#000"), 
#'     bgColor = c("#E41A1C", "#377EB8", "#4DAF4A"),
#'     borderColor = c("#a90000", "#005288", "#0a7f1c")
#'   )
#'   
#'   ui <- fluidPage(
#'     tags$h2("Custom click event"),
#'     calendarOutput(outputId = "cal")
#'   )
#'   
#'   server <- function(input, output, session) {
#'     
#'     output$cal <- renderCalendar({
#'       
#'       input$refresh
#'       
#'       n <- 20
#'       
#'       date_start <- sample(
#'         seq(from = as.POSIXct(Sys.Date()-14), by = "1 hour", length.out = 24*7*4),
#'         n, TRUE
#'       )
#'       date_end <- date_start + sample(1:25, n, TRUE) * 3600
#'       schedules <- data.frame(
#'         id = 1:n, 
#'         calendarId = as.character(sample(1:3, n, TRUE)),
#'         title = LETTERS[1:n],
#'         body = paste("Body schedule", letters[1:n]),
#'         start = format(date_start, format = "%Y-%m-%dT%H:%00:%00"),
#'         end = format(date_end, format = "%Y-%m-%dT%H:%00:%00"),
#'         category = sample(c("allday", "time", "task"), n, TRUE),
#'         stringsAsFactors = FALSE
#'       )
#'       
#'       calendar(defaultView = "month", taskView = TRUE, scheduleView = c("time", "allday")) %>% 
#'         set_calendars_props_df(df = calendarProps) %>% 
#'         add_schedule_df(df = schedules) %>% 
#'         set_events(
#'           clickSchedule = JS("function(event) {alert(event.schedule.id);}")
#'         )
#'     })
#'     
#'     
#'   }
#'   
#'   shinyApp(ui, server)
#'   
#' }
set_events <- function(cal, 
                       afterRenderSchedule = NULL, 
                       beforeCreateSchedule = NULL,
                       beforeDeleteSchedule = NULL,
                       beforeUpdateSchedule = NULL,
                       clickDayname = NULL,
                       clickMorecalendar = NULL,
                       clickSchedule = NULL,
                       clickTimezonesCollapseBtncalendar = NULL) {
  if(!inherits(cal, "calendar")){
    stop("cal must be a calendar object", call. = FALSE)
  }
  cal$x$events <- dropNulls(list(
    afterRenderSchedule = afterRenderSchedule,
    beforeCreateSchedule = beforeCreateSchedule,
    beforeDeleteSchedule = beforeDeleteSchedule,
    beforeUpdateSchedule = beforeUpdateSchedule,
    clickDayname = clickDayname,
    clickMorecalendar = clickMorecalendar,
    clickSchedule = clickSchedule,
    clickTimezonesCollapseBtncalendar = clickTimezonesCollapseBtncalendar
  ))
  cal
}


