# tuicalendr

> Htmlwidget to create interactive calendar with JavaScript library [tui-calendar](https://github.com/nhn/tui.calendar)

[![Travis build status](https://travis-ci.org/dreamRs/tuicalendr.svg?branch=master)](https://travis-ci.org/dreamRs/tuicalendr)
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)



## Installation

You can install from GitHub with:

``` r
remotes::install_github("dreamRs/tuicalendr")
```

## Example

Weekly calendar:

``` r
library(tuicalendr)
calendar(defaultView = "week", taskView = TRUE, scheduleView = c("time", "allday")) %>% 
  setCalendarsProps(id = "courses", name = "Courses", color = "#FFF", bgColor = "#E41A1C") %>% 
  setCalendarsProps(id = "hobbies", name = "Hobbies", color = "#FFF", bgColor = "#377EB8") %>% 
  setCalendarsProps(id = "social", name = "Social", color = "#FFF", bgColor = "#4DAF4A") %>% 
  addSchedule(
    calendarId = "courses",
    title = "R - introduction", 
    body = "What is R?",
    start = sprintf("%s 08:00:00", Sys.Date() - 1),
    end = sprintf("%s 12:30:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  addSchedule(
    calendarId = "courses",
    title = "R - visualisation", 
    body = "With ggplot2",
    start = sprintf("%s 13:30:00", Sys.Date() - 1),
    end = sprintf("%s 18:00:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  addSchedule(
    calendarId = "hobbies",
    title = "Read The Expanse", 
    body = "Vol. 5 : Nemesis Games",
    start = Sys.Date(),
    end = Sys.Date(),
    category = "allday"
  ) %>% 
  addSchedule(
    calendarId = "social",
    title = "Lunch", 
    body = "With Fanny",
    start = sprintf("%s 12:00:00", Sys.Date() + 1),
    end = sprintf("%s 14:00:00", Sys.Date() + 1),
    category = "time"
  )
```
![](man/figures/example-week.png)


Month calendar:

```r
calendar(defaultView = "month", taskView = TRUE, scheduleView = c("time", "allday"), useNav = TRUE) %>% 
  setCalendarsProps(id = "courses", name = "Courses", color = "#FFF", bgColor = "#E41A1C") %>% 
  setCalendarsProps(id = "hobbies", name = "Hobbies", color = "#FFF", bgColor = "#377EB8") %>% 
  setCalendarsProps(id = "social", name = "Social", color = "#FFF", bgColor = "#4DAF4A") %>% 
  addSchedule(
    calendarId = "courses",
    title = "R - introduction", 
    body = "What is R?",
    start = sprintf("%s 08:00:00", Sys.Date() - 1),
    end = sprintf("%s 12:30:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  addSchedule(
    calendarId = "courses",
    title = "R - visualisation", 
    body = "With ggplot2",
    start = sprintf("%s 13:30:00", Sys.Date() - 1),
    end = sprintf("%s 18:00:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  addSchedule(
    calendarId = "hobbies",
    title = "Read The Expanse", 
    body = "Vol. 5 : Nemesis Games",
    start = Sys.Date(),
    end = Sys.Date() + 4,
    category = "allday"
  ) %>% 
  addSchedule(
    calendarId = "social",
    title = "Lunch", 
    body = "With Fanny",
    start = sprintf("%s 12:00:00", Sys.Date() + 7),
    end = sprintf("%s 14:00:00", Sys.Date() + 7),
    category = "time"
  )
```
![](man/figures/example-month.png)


