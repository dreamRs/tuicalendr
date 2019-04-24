

library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Add schedule(s) into calendar with proxy"),
  actionButton(
    inputId = "add", 
    label = "Add random schedule"
  ),
  calendarOutput(outputId = "my_calendar")
)

server <- function(input, output, session) {
  
  output$my_calendar <- renderCalendar({
    calendar(defaultView = "month") %>% 
      setCalendarsProps(id = "a", name = "Schedule A", color = "#FFF", bgColor = "#E41A1C") %>% 
      setCalendarsProps(id = "b", name = "Schedule B", color = "#FFF", bgColor = "#377EB8") %>% 
      setCalendarsProps(id = "c", name = "Schedule C", color = "#FFF", bgColor = "#4DAF4A")
  })
  
  observeEvent(input$add, {
    my_date <- sample(seq(
      from = Sys.Date() - 10,
      to = Sys.Date() + 10,
      by = "1 day"
    ), 1)
    calendarProxy("my_calendar") %>% 
      cal_proxy_schedule(
        id = input$add,
        calendarId = sample(c("a", "b", "c"), 1),
        title = paste("Schedule", input$add), 
        body = paste("What i'm going todo in schedule", input$add),
        start = my_date,
        end = my_date,
        category = "allday"
      )
  })

}

shinyApp(ui, server)
