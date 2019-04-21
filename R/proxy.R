
#' Proxy for calendar htmlwidget
#'
#' @param shinyId single-element character vector indicating the output ID of the
#'   chart to modify (if invoked from a Shiny module, the namespace will be added
#'   automatically).
#' @param session the Shiny session object to which the chart belongs; usually the
#'   default value will suffice.
#'
#' @export
#' 
#' @importFrom shiny getDefaultReactiveDomain
#'
calendarProxy <- function(shinyId, session = shiny::getDefaultReactiveDomain()) {
  if (is.null(session)) {
    stop("calendarProxy must be called from the server function of a Shiny app")
  }
  
  if (!is.null(session$ns) && nzchar(session$ns(NULL)) && substring(shinyId, 1, nchar(session$ns(""))) != session$ns("")) {
    shinyId <- session$ns(shinyId)
  }
  
  structure(
    list(
      session = session,
      id = shinyId,
      x = list()
    ),
    class = c("calendarProxy", "htmlwidgetProxy")
  )
}

#' Call a proxy method
#'
#' @param proxy  A \code{proxy} \code{htmlwidget} object.
#' @param name Proxy method.
#' @param ... Arguments passed to method.
#'
#' @return A \code{htmlwidgetProxy} \code{htmlwidget} object.
#' @noRd
.call_proxy <- function(proxy, name, ...) {
  if (!"htmlwidgetProxy" %in% class(proxy)) 
    stop("This function must be used with a htmlwidgetProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("proxy-tui-calendar-%s", name),
    message = list(id = proxy$id, data = dropNulls(list(...)))
  )
  proxy
}
.call_proxy2 <- function(proxy, name, l) {
  if (!"htmlwidgetProxy" %in% class(proxy)) 
    stop("This function must be used with a htmlwidgetProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("proxy-tui-calendar-%s", name),
    message = list(id = proxy$id, data = l)
  )
  proxy
}




#' @title Navigate into a calendar with Proxy
#' 
#' @description Those functions allow to navigate in the calendar from the server in a Shiny application.
#'
#' @param proxy A \code{\link{calendarProxy}} \code{htmlwidget} object.
#'
#' @export
#' 
#' @name proxy-navigate
#'
cal_proxy_next <- function(proxy) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "nav",
    where = "next"
  )
}

#' @export
#' @rdname proxy-navigate
cal_proxy_prev <- function(proxy) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "nav",
    where = "prev"
  )
}

#' @export
#' @rdname proxy-navigate
cal_proxy_today <- function(proxy) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "nav",
    where = "today"
  )
}





#' @title Change calendar view with Proxy
#' 
#' @description This function allow to change the calendar view from the server in a Shiny application.
#'
#' @param proxy A \code{\link{calendarProxy}} \code{htmlwidget} object.
#' @param view The new view for the calendar: "day", "week" or "month".
#'
#' @export
#'
#' @examples
cal_proxy_view <- function(proxy, view) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "view",
    view = view
  )
}







