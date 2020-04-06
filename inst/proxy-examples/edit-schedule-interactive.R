library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Create and edit schedule"),
  fluidRow(
    column(
      width = 9,
      calendarOutput("my_calendar")
    ),
    column(
      width = 3,
      uiOutput("schedule_update")
    )
  )
)

server <- function(input, output) {
  
  output$my_calendar <- renderCalendar({
    cal <- calendar(
      defaultDate = Sys.Date(),
      useNav = TRUE,
      readOnly = FALSE,
      useCreationPopup = TRUE
    ) %>%
      set_month_options(narrowWeekend = TRUE) %>%
      add_schedule(
        id = "r_intro",
        calendarId = "courses",
        title = "R - introduction",
        body = "What is R?",
        start = paste(Sys.Date(), "08:00:00"),
        end = paste(Sys.Date(), "12:30:00"),
        category = "time"
      )
  })
  
  output$schedule_update <- renderUI({
    if (!is.null(input$my_calendar_update)) {
      changes <- input$my_calendar_update$changes
      tags$div(
        "Schedule",
        tags$b(input$my_calendar_update$schedule$id),
        "have been updated with:",
        tags$ul(
          lapply(
            seq_along(changes),
            function(i) {
              tags$li(
                tags$b(names(changes)[i], ":"),
                changes[[i]]
              )
            }
          )
        )
      )
    }
  })
  
  observeEvent(input$my_calendar_add, {
    cal_proxy_create(
      proxy = "my_calendar",
      .list = input$my_calendar_add
    )
  })
  
  observeEvent(input$my_calendar_update, {
    cal_proxy_update(
      proxy = "my_calendar",
      .list = input$my_calendar_update
    )
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
