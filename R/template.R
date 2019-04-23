
#' @title Set template for a calendar
#' 
#' @description Template JS functions to support customer renderer
#'
#' @param cal A \code{calendar} object.
#' @param milestoneTitle The milestone title(at left column) template function
#' @param taskTitle The task title(at left column) template function
#' @param alldayTitle The allday title(at left column) template function
#' @param ... Additionals arguments, see online documentation.
#' @param title Text to use as title.
#'
#' @note Online JavaScript documentation: \url{https://nhn.github.io/tui.calendar/latest/Template}
#' 
#' @export
#' 
#' @name template
#'
#' @examples
#' calendar(defaultView = "week", taskView = TRUE, scheduleView = c("allday")) %>% 
#'   set_template(
#'     milestoneTitle = js_title("TODO"),
#'     taskTitle = js_title("Assignment"),
#'     alldayTitle = js_title("Full-time")
#'   )
set_template <- function(cal, milestoneTitle = NULL, taskTitle = NULL, alldayTitle = NULL, ...) {
  .widget_options(
    widget = cal,
    name_opt = "template",
    milestoneTitle = milestoneTitle, 
    taskTitle = taskTitle, 
    alldayTitle = alldayTitle, 
    ...
  )
}

#' @export
#' @importFrom htmlwidgets JS
#' @rdname template
js_title <- function(title) {
  JS(sprintf(
    "function() {return  '<span class=\"tui-full-calendar-left-content\">%s</span>';}", title
  ))
}

