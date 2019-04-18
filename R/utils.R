
# dropNulls
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

`%||%` <- function(x, y) {
  if (!is.null(x)) x else y
}


#' Utility function to create Htmlwidget parameters JSON
#'
#' @param bb A \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param ... Arguments for the slot
#'
#' @return A \code{htmlwidget} object.
#' 
#' @importFrom utils modifyList
#'
#' @noRd
.widget_options <- function(widget, name, ...) {
  
  if(!inherits(widget, "htmlwidget")){
    stop("widget must be a htmlwidget object")
  }
  
  if (is.null(widget$x$options[[name]])) {
    widget$x$options[[name]] <- dropNulls(list(...))
  } else {
    widget$x$options[[name]] <- utils::modifyList(
      x = widget$x$options[[name]],
      val = dropNulls(list(...)), 
      keep.null = TRUE
    )
  }
  
  return(widget)
}

#' Utility function to create Htmlwidget parameters JSON
#'
#' @param bb A \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param l List of arguments for the slot
#'
#' @return A \code{htmlwidget} object.
#'
#' @noRd
.widget_options2 <- function(widget, name, l) {
  
  if (is.null(widget$x$options[[name]])) {
    widget$x$options[[name]] <- l
  } else {
    widget$x$options[[name]] <- utils::modifyList(
      x = widget$x$options[[name]],
      val = l, 
      keep.null = TRUE
    )
  }
  
  return(widget)
}
