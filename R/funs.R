#' @title Create an overlay
#'
#' @name create_overlay
#' @description
#' An overlay can be added to existing elements in the diagram.
#'
#' See \code{overlays} argument in the \code{\link{display}} function.
#'
#' Use this structure to create correct overlay structure.
#'
#' @param elementId The bpmn element id to which the overlay will be attached
#' @param label HTML element to use as an overlay
#'
#' @returns An overlay object
#'
#' @export
create_overlay <- function(elementId, label) {
  ret <-
    .not_null_list(elementId = elementId,
                   label = label)
}

#' @description Internal fun to build the htmlwidget content
#'
#' @inheritParams display
#' @returns A list
#'
#' @noRd
build_bpmnContent <- function(bpmnXML,
                              overlays = NULL) {
  # load bpmn content
  if (inherits(bpmnXML,
               "xml_document")) {
    bpmnContent <- as.character(bpmnXML)
  } else if (inherits(bpmnXML,
                      "character")) {
    if (substring(bpmnXML,
                  1,
                  38) == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>") {
      # this must be a string corresponding to the BPMN content of a file
      bpmnContent <- bpmnXML
    } else {
      # this must be a file name
      xml <- xml2::read_xml(bpmnXML)
      bpmnContent <- as.character(xml)
    }
  } else {
    stop("bpmnXML must be a absolute path of BPMN file or the string of the BPMN content !!")
  }
  x <- list(bpmnContent = bpmnContent)
  
  if (length(overlays)) {
    # In case the user passes a single parameter as overlays (instead of a list), we wrap it into a list so the js can work
    x$overlays <- if (is.list(overlays[[1]])) {
      overlays
    } else {
      list(overlays)
    }
  }
  return(x)
}

.not_null_list <- function(...) {
  ret <- list(...)
  ret[lengths(ret) == 0] <- NULL
  ret
}
