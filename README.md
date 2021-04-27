# tuicalendr

> Htmlwidget to create interactive calendar with JavaScript library [tui-calendar](https://github.com/nhn/tui.calendar)

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/dreamRs/tuicalendr.svg?branch=master)](https://travis-ci.org/dreamRs/tuicalendr)
[![R build status](https://github.com/dreamRs/tuicalendr/workflows/R-CMD-check/badge.svg)](https://github.com/dreamRs/tuicalendr/actions)
[![Lifecycle: superseded](https://img.shields.io/badge/lifecycle-superseded-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#superseded)
[![Project Status: Moved to https://github.com/dreamRs/toastui – The project has been moved to a new location, and the version at that location should be considered authoritative.](https://www.repostatus.org/badges/latest/moved.svg)](https://www.repostatus.org/#moved) to [dreamRs/toastui](https://github.com/dreamRs/toastui)
<!-- badges: end -->


# New version

New version of this package is available at https://github.com/dreamRs/toastui


## Installation

You can install from GitHub with:

```r
remotes::install_github("dreamRs/tuicalendr")
```

## Examples

Weekly calendar:

```r
library(tuicalendr)
calendar(defaultView = "week", taskView = TRUE, scheduleView = c("time", "allday")) %>% 
  set_calendars_props(id = "courses", name = "Courses", color = "#FFF", bgColor = "#E41A1C") %>% 
  set_calendars_props(id = "hobbies", name = "Hobbies", color = "#FFF", bgColor = "#377EB8") %>% 
  set_calendars_props(id = "social", name = "Social", color = "#FFF", bgColor = "#4DAF4A") %>% 
  add_schedule(
    calendarId = "courses",
    title = "R - introduction", 
    body = "What is R?",
    start = sprintf("%s 08:00:00", Sys.Date() - 1),
    end = sprintf("%s 12:30:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  add_schedule(
    calendarId = "courses",
    title = "R - visualisation", 
    body = "With ggplot2",
    start = sprintf("%s 13:30:00", Sys.Date() - 1),
    end = sprintf("%s 18:00:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  add_schedule(
    calendarId = "hobbies",
    title = "Read The Expanse", 
    body = "Vol. 5 : Nemesis Games",
    start = Sys.Date(),
    end = Sys.Date(),
    category = "allday"
  ) %>% 
  add_schedule(
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
  set_calendars_props(id = "courses", name = "Courses", color = "#FFF", bgColor = "#E41A1C") %>% 
  set_calendars_props(id = "hobbies", name = "Hobbies", color = "#FFF", bgColor = "#377EB8") %>% 
  set_calendars_props(id = "social", name = "Social", color = "#FFF", bgColor = "#4DAF4A") %>% 
  add_schedule(
    calendarId = "courses",
    title = "R - introduction", 
    body = "What is R?",
    start = sprintf("%s 08:00:00", Sys.Date() - 1),
    end = sprintf("%s 12:30:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  add_schedule(
    calendarId = "courses",
    title = "R - visualisation", 
    body = "With ggplot2",
    start = sprintf("%s 13:30:00", Sys.Date() - 1),
    end = sprintf("%s 18:00:00", Sys.Date() - 1),
    category = "time"
  ) %>% 
  add_schedule(
    calendarId = "hobbies",
    title = "Read The Expanse", 
    body = "Vol. 5 : Nemesis Games",
    start = Sys.Date(),
    end = Sys.Date() + 4,
    category = "allday"
  ) %>% 
  add_schedule(
    calendarId = "social",
    title = "Lunch", 
    body = "With Fanny",
    start = sprintf("%s 12:00:00", Sys.Date() + 7),
    end = sprintf("%s 14:00:00", Sys.Date() + 7),
    category = "time"
  )
```
![](man/figures/example-month.png)


