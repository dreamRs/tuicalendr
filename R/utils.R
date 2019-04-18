
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
#' @param name_opt Slot's name to edit
#' @param ... Arguments for the slot
#'
#' @return A \code{htmlwidget} object.
#' 
#' @importFrom utils modifyList
#'
#' @noRd
.widget_options <- function(widget, name_opt, ...) {
  
  if(!inherits(widget, "htmlwidget")){
    stop("widget must be a htmlwidget object")
  }
  
  if (is.null(widget$x$options[[name_opt]])) {
    widget$x$options[[name_opt]] <- dropNulls(list(...))
  } else {
    widget$x$options[[name_opt]] <- utils::modifyList(
      x = widget$x$options[[name_opt]],
      val = dropNulls(list(...)), 
      keep.null = TRUE
    )
  }
  
  return(widget)
}

#' Utility function to create Htmlwidget parameters JSON
#'
#' @param bb A \code{htmlwidget} object.
#' @param name_opt Slot's name to edit
#' @param l List of arguments for the slot
#'
#' @return A \code{htmlwidget} object.
#'
#' @noRd
.widget_options2 <- function(widget, name_opt, l) {
  
  if (is.null(widget$x$options[[name_opt]])) {
    widget$x$options[[name_opt]] <- l
  } else {
    widget$x$options[[name_opt]] <- utils::modifyList(
      x = widget$x$options[[name_opt]],
      val = l, 
      keep.null = TRUE
    )
  }
  
  return(widget)
}
