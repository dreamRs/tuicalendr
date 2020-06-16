


library(shiny)
library(tuicalendr)


calendarProps <- data.frame(
  id = c("1", "2", "3"), 
  name = c("TODO", "Meetings", "Tasks"),
  color = c("#FFF", "#FFF", "#000"), 
  bgColor = c("#E41A1C", "#377EB8", "#4DAF4A"),
  borderColor = c("#a90000", "#005288", "#0a7f1c")
)

ui <- fluidPage(
  tags$h2("Example without proxy"),
  actionButton(
    inputId = "refresh", 
    label = "Refresh data",
    icon = icon("refresh"), 
    width = "100%"
  ),
  calendarOutput(outputId = "cal"),
  verbatimTextOutput(outputId = "click")
)

server <- function(input, output, session) {
  
  output$cal <- renderCalendar({
    
    input$refresh
    
    n <- 20
    
    date_start <- sample(
      seq(from = as.POSIXct(Sys.Date()-14), by = "1 hour", length.out = 24*7*4),
      n, TRUE
    )
    date_end <- date_start + sample(1:25, n, TRUE) * 3600
    schedules <- data.frame(
      id = 1:n, 
      calendarId = as.character(sample(1:3, n, TRUE)),
      title = LETTERS[1:n],
      body = paste("Body schedule", letters[1:n]),
      start = format(date_start, format = "%Y-%m-%dT%H:%00:%00"),
      end = format(date_end, format = "%Y-%m-%dT%H:%00:%00"),
      category = sample(c("allday", "time", "task"), n, TRUE),
      stringsAsFactors = FALSE
    )
    
    calendar(defaultView = "month", taskView = TRUE, scheduleView = c("time", "allday")) %>% 
      # set_month_options(visibleWeeksCount = 2) %>%
      set_calendars_props_df(df = calendarProps) %>% 
      add_schedule_df(df = schedules)
  })
  
  output$click <- renderPrint({
    input$cal_click
  })
  
}

shinyApp(ui, server)

