#' @title Create an overlay
#'
#' @name create_overlay
#' @description 
#' An overlay can be added to existing elements in the diagram.
#' 
#' See \code{overlays} argument in the \code{\link{display}} function.
#' 
#' Use this function to create the correct overlay structure.
#' 
#' @param elementId The bpmn element id to which the overlay will be attached
#' @param label 'HTML' element to use as an overlay
#' @param style The style of the overlay
#'      Use \code{\link{create_style}} function to create the style object of an overlay.
#'
#' @returns An overlay object
#'
#' @export
create_overlay <- function(elementId, label, style = NULL) {
  ret <-
    .not_null_list(
      elementId = elementId,
      label = label,
      style = style
    )
}

#' @title Create the style of an overlay
#'
#' @name create_style
#' @description
#' When adding an overlay to an existing element in a diagram, it's possible to customize its style.
#'
#' Refer to the \code{style} parameter in the \code{\link{create_overlay}} function for more information.
#'
#' Use this function to create the correct style structure for an overlay.
#'
#' @param font The font style of the overlay
#'      Use \code{\link{create_font}} function to create the font style object for the overlay.
#' @param fill The fill style of the overlay
#'      Use \code{\link{create_fill}} function to create the fill style object for the overlay.
#' @param stroke The stroke style of the overlay
#'      Use \code{\link{create_stroke}} function to create the stroke style object for the overlay.
#'
#' @returns The style object of the overlay
#'
#' @export
create_style <- function(font = NULL, fill = NULL, stroke = NULL) {
  ret <-
    .not_null_list(
      font = font,
      fill = fill,
      stroke = stroke
    )
}

#' @title Create the font style of an overlay
#'
#' @name create_font
#' @description
#' When adding an overlay to an existing element in a diagram, it's possible to customize its font style.
#'
#' Refer to the \code{font} parameter in the \code{\link{create_style}} function for more information.
#'
#' Use this function to create the correct font structure for an overlay.
#'
#' @param color The color of the font of the overlay
#' @param size The size of the font of the overlay
#'
#' @returns The font style object of the overlay
#'
#' @export
create_font <- function(color = NULL, size = NULL) {
  ret <-
    .not_null_list(
      color = color,
      size = size
    )
}

#' @title Create the fill style of an overlay
#'
#' @name create_fill
#' @description
#' When adding an overlay to an existing element in a diagram, it's possible to customize how it is filled.
#'
#' Refer to the \code{fill} parameter in the \code{\link{create_style}} function for more information.
#'
#' Use this function to create the correct fill structure for an overlay.
#'
#' @param color The color of the background of the overlay
#'
#' @returns The fill style object of the overlay
#'
#' @export
create_fill <- function(color) {
  ret <-
    .not_null_list(
      color = color
    )
}

#' @title Create the stroke style of an overlay
#'
#' @name create_stroke
#' @description
#' When adding an overlay to an existing element in a diagram, it's possible to customize its stroke. style.
#'
#' Refer to the \code{stroke.} parameter in the \code{\link{create_style}} function for more information.
#' 
#' Use this function to create the correct stroke structure for an overlay.
#'
#' @param color The color of the stroke of the overlay
#'
#' @returns The stroke style object of the overlay
#'
#' @export
create_stroke <- function(color) {
  ret <-
    .not_null_list(
      color = color
    )
}

#' @description Internal fun to build the 'htmlwidget' content
#'
#' @inheritParams display
#' @returns A list
#'
#' @noRd
build_bpmnContent <- function(
  bpmnXML,
  overlays = NULL,
  enableDefaultOverlayStyle
) {
  # load bpmn content
  if (inherits(
    bpmnXML,
    "xml_document"
  )) {
    bpmnContent <- as.character(bpmnXML)
  } else if (
    inherits(
      bpmnXML,
      "character"
    )) {
    if (
      substring(
        bpmnXML,
        1,
        38
      ) == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>") {
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
  x <- list(
    bpmnContent = bpmnContent,
    enableDefaultOverlayStyle = enableDefaultOverlayStyle
  )

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
