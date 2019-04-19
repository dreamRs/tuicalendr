
.add_calendar <- function(widget, calendar) {

  widget$x$options$calendars <- c(
    widget$x$options$calendars, 
    list(calendar)
  )
  widget
}

#' @title Calendars properties
#' 
#' @description Define calendars properties for schedules
#'
#' @param cal A \code{calendar} object.
#' @param id Id for the calendar, refer to \code{calendarId} in \code{\link{addSchedule}}
#' @param name The calendar name.
#' @param color The text color when schedule is displayed.
#' @param bgColor The background color schedule is displayed.
#' @param borderColor The color of left border or bullet point when schedule is displayed.
#'
#' @export
#' 
#' @name set-calendars
#'
setCalendarsProps <- function(cal, id, name, color, bgColor, borderColor = bgColor) {
  .add_calendar(
    widget = cal,
    calendar = list(
      id = id,
      name = name,
      bgColor = bgColor,
      borderColor = borderColor
    )
  )
}

#' @param df a \code{data.frame} with calendars data, columns must have valid calendars properties option.
#'
#' @export
#'
#' @rdname set-calendars
setCalendarsPropsDF <- function(cal, df) {
  df <- as.data.frame(df)
  df <- apply(X = df, MARGIN = 1, FUN = as.list)
  for (i in seq_along(df)) {
    cal <- .add_calendar(
      widget = cal,
      calendar = df[[i]]
    )
  }
  cal
}
