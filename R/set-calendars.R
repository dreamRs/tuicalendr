
#' @title Calendars properties
#' 
#' @description Define calendadrs properties for schedules
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
setCalendarsProps <- function(cal, id, name, color, bgColor, borderColor = bgColor) {
  .widget_options(
    widget = cal,
    name_opt = "calendars",
    id = id,
    name = name,
    bgColor = bgColor,
    borderColor = borderColor
  )
}


