
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
#' @param date A specific date to navigate to.
#'
#' @export
#' 
#' @name proxy-navigate
#'
#' @examples 
#' if (interactive()) {
#'   library(shiny)
#'   
#'   ui <- fluidPage(
#'     tags$h2("Navigate in calendar with actionButtons"),
#'     actionButton(
#'       inputId = "prev", 
#'       label = "Previous"
#'     ),
#'     actionButton(
#'       inputId = "next_", 
#'       label = "Next"
#'     ),
#'     actionButton(
#'       inputId = "today", 
#'       label = "Today"
#'     ),
#'     calendarOutput(outputId = "my_calendar")
#'   )
#'   
#'   server <- function(input, output, session) {
#'     
#'     output$my_calendar <- renderCalendar({
#'       calendar(defaultView = "month", useNav = FALSE)
#'     })
#'     
#'     observeEvent(input$prev, cal_proxy_prev("my_calendar"))
#'     observeEvent(input$next_, cal_proxy_next("my_calendar"))
#'     observeEvent(input$today, cal_proxy_today("my_calendar"))
#'     
#'   }
#'   
#'   shinyApp(ui, server)
#' }
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

#' @export
#' @rdname proxy-navigate
cal_proxy_date <- function(proxy, date) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "nav",
    where = "date",
    date = date
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
#' if (interactive()) {
#'   library(shiny)
#'   
#'   ui <- fluidPage(
#'     tags$h2("Navigate in calendar with actionButtons"),
#'     radioButtons(
#'       inputId = "view", 
#'       label = "Change view:", 
#'       choices = c("day", "week", "month"), 
#'       inline = TRUE
#'     ),
#'     calendarOutput(outputId = "my_calendar")
#'   )
#'   
#'   server <- function(input, output, session) {
#'     
#'     output$my_calendar <- renderCalendar({
#'       calendar(defaultView = "day", scheduleView = "allday") %>% 
#'         addSchedule(
#'           title = "Today planning", 
#'           start = Sys.Date(),
#'           end = Sys.Date(),
#'           category = "allday"
#'         )
#'     })
#'     
#'     observeEvent(
#'       input$view, 
#'       cal_proxy_view("my_calendar", input$view), 
#'       ignoreInit = TRUE
#'     )
#'     
#'   }
#'   
#'   shinyApp(ui, server)
#' }
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



#' @title Create / Update / Delete schedule(s) with Proxy
#' 
#' @description These functions allow to create new schedule(s), update existing
#'  ones and delete schedule in a calendar within the server in a Shiny application.
#'
#' @param proxy A \code{\link{calendarProxy}} \code{htmlwidget} object.
#' @param start The start time.
#' @param end The end time. 
#' @param title The schedule title.
#' @param body The schedule body text which is text/plain.
#' @param id An id for the schedule.
#' @param calendarId An id for the calendar.
#' @param category The schedule type ('milestone', 'task', allday', 'time').
#' @param ... Additionnal arguments passed to the JavaScript method.
#' @param .list A \code{list} with same information as above, useful with \code{input$<outputId>_add_schedule}.
#'
#' @export
#' 
#' @name proxy-schedule
#'
cal_proxy_create <- function(proxy, start = NULL, end = NULL, 
                               title = NULL, body = NULL, id = NULL,
                               calendarId = NULL, category = NULL, ...,
                               .list = NULL) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  if (is.null(id)) {
    id <- paste0("shd_", sample.int(1e6, 1))
  }
  if (!is.null(.list)) {
    .list$id <- id
    schedule <- list(.list)
  } else {
    schedule <- list(dropNulls(list(
      id = id,
      calendarId = calendarId,
      title = title,
      body = body,
      start = start,
      end = end,
      category = category,
      ...
    )))
  }
  .call_proxy(
    proxy = proxy,
    name = "create",
    schedule = schedule
  )
}

#' @rdname proxy-schedule
#' @export
cal_proxy_delete <- function(proxy, calendarId = NULL, id = NULL) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "delete",
    calendarId = calendarId,
    id = id
  )
}

#' @rdname proxy-schedule
#' @export
cal_proxy_update <- function(proxy, calendarId = NULL, id = NULL,
                             start = NULL, end = NULL, 
                             title = NULL, body = NULL, 
                             category = NULL, ...,
                             .list = NULL) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  if (is.null(.list)) {
    .list <- dropNulls(list(
      id = id,
      calendarId = calendarId,
      title = title,
      body = body,
      start = start,
      end = end,
      category = category,
      ...
    ))
  }
  .call_proxy(
    proxy = proxy,
    name = "update",
    calendarId = calendarId,
    id = id,
    schedule = .list
  )
}


#' @title Clear calendar with Proxy
#' 
#' @description This function allow to delete all schedules and clear view.
#'
#' @param proxy A \code{\link{calendarProxy}} \code{htmlwidget} object.
#' @param immediately Render it immediately. Or wait, if you want to add schedule after that for example.
#'
#' @export
#'
cal_proxy_clear <- function(proxy, immediately = TRUE) {
  if (is.character(proxy)) {
    proxy <- calendarProxy(proxy)
  }
  .call_proxy(
    proxy = proxy,
    name = "clear",
    immediately = immediately
  )
}
