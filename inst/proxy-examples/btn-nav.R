

library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Navigate in calendar with actionButtons"),
  fluidRow(
    column(
      width = 4,
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
      )
    ),
    column(
      width = 4,
      dateInput(
        inputId = "date",
        label = NULL,
        value = Sys.Date()
      )
    ),
    column(
      width = 4,
      verbatimTextOutput(outputId = "dates")
    )
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
  observe(cal_proxy_date("my_calendar", input$date))
  
  output$dates <- renderPrint({
    input$my_calendar_dates
  })
}

shinyApp(ui, server)
