
#' @title Set theme for a calendar
#' 
#' @description Full configuration for theme.
#' "common" prefix is for entire calendar. "common" properties can be overriden by "week", "month".
#' "week" prefix is for weekly and daily view.
#' "month" prefix is for monthly view.
#'
#' @param cal A \code{calendar} object.
#' @param ... Named arguments to customize appearance with CSS. See online documentation for full list of options.
#' @param theme_list Alternative to \code{...} for using a list.
#'
#' @note Online JavaScript documentation: \url{https://nhn.github.io/tui.calendar/latest/themeConfig}
#' 
#' @export
#' 
#'
#' @examples
#' calendar(defaultView = "month") %>%
#'   set_theme(
#'     common.border = '2px solid #e5e5e5',
#'     common.backgroundColor = 'white',
#'     common.holiday.color = '#ff4040',
#'     common.saturday.color = '#0000FF',
#'     common.dayname.color = '#333',
#'     common.today.color = '#333'
#'   )
set_theme <- function(cal, ..., theme_list = NULL) {
  .widget_options2(
    widget = cal,
    name_opt = "theme",
    l = dropNulls(c(list(...), theme_list))
  )
}
