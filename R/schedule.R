
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
#'
#' @export
#' 
#' @name add-schedule
#'
addSchedule <- function(cal, start, end, title, body = NULL, id = NULL,
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


#' @param data a \code{data.frame} with schedule data, columns must have valid shedule name option.
#'
#' @export
#'
#' @rdname add-schedule
addScheduleDF <- function(cal, data) {
  data <- apply(X = data, MARGIN = 1, FUN = as.list)
  for (i in seq_along(data)) {
    cal <- .add_schedule(
      widget = cal,
      schedule = data[[i]]
    )
  }
  cal
}

