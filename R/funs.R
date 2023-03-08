# Custom data types
OverlayShapePosition <- c("top-left", "top-right", "top-center", "bottom-left", "bottom-right","bottom-center", "middle-left", "middle-right")
OverlayEdgePosition <- c("start", "end", "middle")

#' @title Create an overlay
#'
#' @name create_overlay
#' @description 
#' An overlay can be added to existing elements in the diagram.
#' 
#' See the \code{overlays} argument in the \code{\link{display}} function.
#' 
#' Use this function to create the correct overlay structure.
#' 
#' @param elementId The bpmn element id to which the overlay will be attached
#' @param label 'HTML' element to use as an overlay
#' @param style The style of the overlay.
#'      Use \code{\link{create_style}} function to create the style object of an overlay and be aware of the `enableDefaultOverlayStyle` parameter in the \code{\link{display}} function.
#' @param position The position of the overlay
#'      If the bpmn element where the overlay will be attached is a Shape, use \code{\link{OverlayShapePosition}}.
#'      Otherwise, use \code{\link{OverlayEdgePosition}}.
#'
#' @returns An overlay object
#'
#' @export
create_overlay <- function(elementId, label, style = NULL, position = NULL) {
  if (!is.null(position) && !(position %in% c(OverlayShapePosition, OverlayEdgePosition))) {
    stop(
      paste("Error: position must be:","\n",
            "\t- NULL","\n",
            "\t- if the overlay will be attached on a Shape, one of the following values: ", paste(OverlayShapePosition, collapse = ", "), "\n",
            "\t- if the overlay will be attached on an Edge, one of the following values: ", paste(OverlayEdgePosition, collapse = ", ")
      )
    )
  }
  
  ret <-
    .not_null_list(
      elementId = elementId,
      label = label,
      style = style,
      position = position
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








# Define test values
shape_element <- "shape_id"
edge_element <- "edge_id"
overlay_label <- "<div>Overlay</div>"
invalid_position <- "invalid_position"

# Test the function with valid input
test_that("create_overlay returns the expected overlay object for a shape element", {
  overlay_shape <- create_overlay(elementId = shape_element, label = overlay_label, style = NULL, position = "top-left")
  expect_equal(names(overlay_shape), c("elementId", "label", "style", "position"))
  expect_equal(overlay_shape$elementId, shape_element)
  expect_equal(overlay_shape$label, overlay_label)
  expect_null(overlay_shape$style)
  expect_equal(overlay_shape$position, "top-left")
})

test_that("create_overlay returns the expected overlay object for an edge element", {
  overlay_edge <- create_overlay(elementId = edge_element, label = overlay_label, style = NULL, position = "start")
  expect_equal(names(overlay_edge), c("elementId", "label", "style", "position"))
  expect_equal(overlay_edge$elementId, edge_element)
  expect_equal(overlay_edge$label, overlay_label)
  expect_null(overlay_edge$style)
  expect_equal(overlay_edge$position, "start")
})

# Test the function with invalid input
test_that("create_overlay throws an exception when position is not valid", {
  expect_error(create_overlay(elementId = shape_element, label = overlay_label, style = NULL, position = invalid_position),
               "position must be")
})

test_that("create_overlay does not throw an exception when position is null", {
  expect_no_error(create_overlay(elementId = shape_element, label = overlay_label, style = NULL, position = NULL))
})


# test the function with valid parameter values
my_function("top")
my_function("end")

# test the function with an invalid parameter value
my_function("invalid")

