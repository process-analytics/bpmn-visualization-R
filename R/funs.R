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
#' @param label 'HTML' element to use as an overlay
#' @param style The style of the overlay
#'      Use \code{\link{create_style}} function to create the style of an overlay object.
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
#' When an overlay is added to an existing element in the diagram, it's possible to style it.
#'
#' See \code{style} argument in the \code{\link{create_overlay}} function.
#'
#' Use this structure to create correct style structure.
#'
#' @param font The font style of an overlay
#'      Use \code{\link{create_font}} function to create the style of an overlay object.
#' @param fill The fill style of an overlay
#'      Use \code{\link{create_fill}} function to create the style of an overlay object.
#' @param stroke The stroke style of an overlay
#'      Use \code{\link{create_stroke}} function to create the style of an overlay object.
#'
#' @returns The style object of an overlay
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
#' When an overlay is added to an existing element in the diagram, it's possible to style its font.
#'
#' See \code{font} argument in the \code{\link{create_style}} function.
#'
#' Use this structure to create correct font structure.
#'
#' @param color The color of the font of an overlay
#' @param size The size of the font of an overlay
#'
#' @returns The font style object of an overlay
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
#' When an overlay is added to an existing element in the diagram, it's possible to style how it is filled.
#'
#' See \code{fill} argument in the \code{\link{create_style}} function.
#'
#' Use this structure to create correct fill structure.
#'
#' @param color The color of the background of an overlay
#'
#' @returns The fill style object of an overlay
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
#' When an overlay is added to an existing element in the diagram, it's possible to style its stroke.
#'
#' See \code{stroke} argument in the \code{\link{create_style}} function.
#'
#' Use this structure to create correct stroke structure.
#'
#' @param color The color of the stroke of an overlay
#'
#' @returns The stroke style object of an overlay
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
  overlays = NULL
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
    bpmnContent = bpmnContent
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
