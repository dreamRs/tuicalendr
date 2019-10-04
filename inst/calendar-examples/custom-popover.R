
#  ------------------------------------------------------------------------
#
# Title : Custom popover
#    By : Victor
#  Date : 2019-10-04
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(shiny)
library(tuicalendr)
library(shinyWidgets)



# Datas -------------------------------------------------------------------

calendarProps <- data.frame(
  id = c("1", "2", "3"), 
  name = c("TODO", "Meetings", "Tasks"),
  color = c("#FFF", "#FFF", "#000"), 
  bgColor = c("#E41A1C", "#377EB8", "#4DAF4A"),
  borderColor = c("#a90000", "#005288", "#0a7f1c")
)


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




# shiny -------------------------------------------------------------------

ui <- fluidPage(
  fluidRow(
    column(
      width = 8, offset = 2,
      tags$h2("Custom popover with HTML"),
      calendarOutput(outputId = "cal")
    )
  )
)

server <- function(input, output, session) {
  
  output$cal <- renderCalendar({
    calendar(defaultView = "month", taskView = TRUE, useDetailPopup = FALSE) %>% 
      # set_month_options(visibleWeeksCount = 2) %>%
      set_calendars_props_df(df = calendarProps) %>% 
      add_schedule_df(df = schedules) %>%
      set_events(
        clickSchedule = JS(paste0(
          "function(event) {Shiny.setInputValue('",
          "calendar_id_click", 
          "', {id: event.schedule.id, x: event.event.clientX, y: event.event.clientY});}"
        ))
      )
  })

  
  observeEvent(input$calendar_id_click, {
    removeUI(selector = "#calendar_panel")
    id <- as.numeric(input$calendar_id_click$id)
    # Get the appropriate line clicked
    sched <- schedules[schedules$id == id, ]

    insertUI(
      selector = "body",
      ui = absolutePanel(
        id = "calendar_panel",
        top = input$calendar_id_click$y,
        left = input$calendar_id_click$x, 
        draggable = FALSE,
        panel(
          status = "primary",
          actionLink(
            inputId = "close_calendar_panel", 
            label = NULL, icon = icon("close"), 
            style = "position: absolute; top: 5px; right: 5px;"
          ),
          tags$br(),
          tags$div(
            style = "text-align: center;",
            tags$p(
              "Here you can put custom", tags$b("HTML"), "elements."
            ),
            tags$p(
              "You clicked on schedule", sched$id, 
              "starting from", sched$start,
              "ending", sched$end
            )
          )
        )
      )
    )
  })
  
  observeEvent(input$close_calendar_panel, {
    removeUI(selector = "#calendar_panel")
  })
  
}

shinyApp(ui, server)
