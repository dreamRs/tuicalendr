

library(shiny)
library(tui.calendar)

ui <- fluidPage(
  tags$h2("Navigate in calendar with actionButtons"),
  actionButton(
    inputId = "prev", 
    label = "Previous"
  ),
  actionButton(
    inputId = "next_", 
    label = "Next"
  ),
  actionButton(
    inputId = "today", 
    label = "Today"
  ),
  calendarOutput(outputId = "my_calendar")
)

server <- function(input, output, session) {
  
  output$my_calendar <- renderCalendar({
    calendar(defaultView = "month", useNav = FALSE)
  })
  
  observeEvent(input$prev, cal_proxy_prev("my_calendar"))
  observeEvent(input$next_, cal_proxy_next("my_calendar"))
  observeEvent(input$today, cal_proxy_today("my_calendar"))
  
}

shinyApp(ui, server)
