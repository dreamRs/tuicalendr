
.add_schedule <- function(widget, schedule) {
  
  schedule <- modifyList(
    val = schedule,
    x = list(
      category = "time",
      dueDateClass = "",
      id = sample.int(1e6, 1),
      calendarId = "1"
    )
  )
  
  widget$x$schedules <- append(
    x = widget$x$schedules, 
    values = list(schedule)
  )
  widget
}


#' @title Add schedules
#'
#' @param cal A \code{calendar} object.
#' @param start The start time.
#' @param end The end time. 
#' @param title The schedule title.
#' @param body The schedule body text which is text/plain.
#' @param id An id for the schedule.
#' @param calendarId An id for the calendar.
#' @param category The schedule type ('milestone', 'task', allday', 'time').
#' @param ... Additionnal arguments passed to the JavaScript method, 
#'  see \url{https://nhn.github.io/tui.calendar/latest/Schedule}.
#'
#' @export
#' 
#' @name add-schedule
#'
add_schedule <- function(cal, start, end, title, body = NULL, id = NULL,
                        calendarId = NULL, category = NULL, ...) {
  .add_schedule(
    widget = cal,
    schedule = dropNulls(list(
      id = id, 
      calendarId = calendarId,
      title = title,
      body = body,
      start = start,
      end = end,
      category = category,
      ...
    ))
  )
}


#' @param df a \code{data.frame} with schedule data, columns must have valid shedule name option.
#'
#' @export
#'
#' @rdname add-schedule
add_schedule_df <- function(cal, df) {
  df <- as.data.frame(df)
  df <- apply(X = df, MARGIN = 1, FUN = as.list)
  for (i in seq_along(df)) {
    cal <- .add_schedule(
      widget = cal,
      schedule = df[[i]]
    )
  }
  cal
}

