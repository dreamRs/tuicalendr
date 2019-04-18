#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget shinyWidgetOutput shinyRenderWidget
#'
#' @export
calendar <- function(defaultView = c("week", "month", "day"), taskView = FALSE, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    options = list(
      defaultView = match.arg(defaultView),
      taskView = taskView
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'calendar',
    x = x,
    width = width,
    height = height,
    package = 'tui.calendar',
    elementId = elementId
  )
}

#' Shiny bindings for calendar
#'
#' Output and render functions for using calendar within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a calendar
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name calendar-shiny
#'
#' @export
calendarOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'calendar', width, height, package = 'tui.calendar')
}

#' @rdname calendar-shiny
#' @export
renderCalendar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, calendarOutput, env, quoted = TRUE)
}
