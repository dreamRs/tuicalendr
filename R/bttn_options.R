
#' Options for buttons displayed above calendar
#'
#' @param today_label Text to display on today button.
#' @param prev_label Text to display on prev button.
#' @param next_label Text to display on next button.
#' @param class Class to add to buttons.
#' @param bg Background color.
#' @param color Text color.
#' 
#' @note Buttons are generated with the following CSS library : \url{http://bttn.surge.sh/}, 
#'  where you can find available options for \code{class} argument.
#'
#' @return a \code{list}.
#' @export
#' 
#' @importFrom htmltools tags doRenderTags
#' 
#' @examples 
#' # Use another button style
#' calendar(
#'   defaultView = "month", useNav = TRUE, 
#'   bttnOpts = bttn_options(
#'     class = "bttn-stretch bttn-sm bttn-warning"
#'   )
#' )
#' 
#' # Custom colors (background and text)
#' calendar(
#'   defaultView = "month", useNav = TRUE, 
#'   bttnOpts = bttn_options(bg = "#FE2E2E", color = "#FFF")
#' )
#' 
#' # both
#' calendar(
#'   defaultView = "month", useNav = TRUE, 
#'   bttnOpts = bttn_options(
#'     bg = "#04B431", color = "#FFF", 
#'     class = "bttn-float bttn-md"
#'   )
#' )
bttn_options <- function(today_label = "Today",
                         prev_label = htmltools::tags$i(class = "fa fa-chevron-left"),
                         next_label = htmltools::tags$i(class = "fa fa-chevron-right"),
                         class = "bttn-jelly bttn-sm bttn-primary",
                         bg = NULL, color = NULL) {
  dropNulls(list(
    today_label = doRenderTags(today_label),
    prev_label = doRenderTags(prev_label),
    next_label = doRenderTags(next_label),
    class = paste0(" ", class),
    bg = bg, color = color
  ))
}


