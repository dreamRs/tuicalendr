

library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Create schedule(s) into calendar"),
  calendarOutput(outputId = "my_calendar"),
  verbatimTextOutput(outputId = "created")
)

server <- function(input, output, session) {
  
  output$my_calendar <- renderCalendar({
    calendar(defaultView = "month", useCreationPopup = TRUE, readOnly = FALSE) %>% 
      setCalendarsProps(id = "a", name = "Schedule A", color = "#FFF", bgColor = "#E41A1C") %>% 
      setCalendarsProps(id = "b", name = "Schedule B", color = "#FFF", bgColor = "#377EB8") %>% 
      setCalendarsProps(id = "c", name = "Schedule C", color = "#FFF", bgColor = "#4DAF4A")
  })
  
  observeEvent(input$my_calendar_add_schedule, {
    calendarProxy("my_calendar") %>% 
      cal_proxy_schedule(
        .list = input$my_calendar_add_schedule
      )
  })
  
  output$created <- renderPrint({
    input$my_calendar_add_schedule
  })
  
}

shinyApp(ui, server)
