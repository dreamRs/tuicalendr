#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget shinyWidgetOutput shinyRenderWidget sizingPolicy
#'
#' @export
calendar <- function(defaultView = c("week", "month", "day"), 
                     taskView = FALSE,
                     scheduleView = FALSE,
                     readOnly = TRUE, 
                     useNav = TRUE,
                     width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    options = list(
      defaultView = match.arg(defaultView),
      taskView = taskView,
      scheduleView = scheduleView,
      isReadOnly = readOnly#,
    ),
    schedules = list(),
    useNav = isTRUE(useNav)
  )
  
  dependencies <- NULL
  if (isTRUE(useNav)) {
    dependencies <- list(
      rmarkdown::html_dependency_font_awesome()
    )
  }

  # create widget
  htmlwidgets::createWidget(
    # name = ifelse(isTRUE(useNav), "calendar_nav", "calendar"),
    name = "calendar",
    x = x,
    width = width,
    height = height,
    dependencies = dependencies,
    package = "tui.calendar",
    elementId = elementId,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = "100%",
      viewer.defaultHeight = "100%",
      viewer.defaultWidth = "100%",
      knitr.figure = FALSE,
      knitr.defaultWidth = "100%",
      knitr.defaultHeight = "800px",
      browser.fill = TRUE,
      viewer.suppress = FALSE,
      browser.external = TRUE
    )
  )
}

#' @importFrom htmltools tagList tags
calendar_html <- function(id, style, class, ...) {
  tagList(
    tags$div(
      id = paste0(id, "_menu"),
      tags$span(
        id = paste0(id, "_menu_navi"),
        tags$button(
          type = "button", class = "btn bttn-jelly bttn-sm bttn-primary bttn-no-outline move-today", `data-action` = "move-today",
          "Today"
        ),
        tags$button(
          type="button", class = "btn bttn-jelly bttn-sm bttn-primary bttn-no-outline move-day", `data-action` = "move-prev",
          tags$i(class = "fa fa-chevron-left", `data-action` = "move-prev")
        ),
        tags$button(
          type="button", class = "btn bttn-jelly bttn-sm bttn-primary bttn-no-outline move-day", `data-action` = "move-next",
          tags$i(class = "fa fa-chevron-right", `data-action` = "move-next")
        )
      ),
      tags$span(id = paste0(id, "_renderRange"), class = "render-range")
    ),
    tags$br(),
    tags$div(id = id, style = style, class = class, ...)
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
