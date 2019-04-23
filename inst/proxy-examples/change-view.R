

library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Navigate in calendar with actionButtons"),
  radioButtons(
    inputId = "view", 
    label = "Change view:", 
    choices = c("day", "week", "month"), 
    inline = TRUE
  ),
  calendarOutput(outputId = "my_calendar")
)

server <- function(input, output, session) {
  
  output$my_calendar <- renderCalendar({
    calendar(defaultView = "day", scheduleView = "allday") %>% 
      addSchedule(
        title = "Today planning", 
        start = Sys.Date(),
        end = Sys.Date(),
        category = "allday"
      )
  })
  
  observeEvent(
    input$view, 
    cal_proxy_view("my_calendar", input$view), 
    ignoreInit = TRUE
  )
  
}

shinyApp(ui, server)
