#' @title The overlay positions on \code{Shape}
#'
#' @description
#' To specify the position when creating an overlay object that will be attached to BPMN \code{Shape} elements in the diagram.
#'
#' \code{overlay_shape_position} includes the following positions:
#'
#' - \code{"top-left"}
#' - \code{"top-right"}
#' - \code{"top-center"}
#' - \code{"bottom-left"}
#' - \code{"bottom-right"}
#' - \code{"bottom-center"}
#' - \code{"middle-left"}
#' - \code{"middle-right"}
#'
#' Use these constants as the \code{position} argument in the \code{\link{create_overlay}} function.
#'
#' @export
overlay_shape_position <-
  c(
    "top-left",
    "top-right",
    "top-center",
    "bottom-left",
    "bottom-right",
    "bottom-center",
    "middle-left",
    "middle-right"
  )

#' @title The overlay positions on \code{Edge}
#'
#' @description
#' To specify the position when creating an overlay object that will be attached to BPMN \code{Edge} elements in the diagram.
#'
#' \code{overlay_edge_position} includes the following positions:
#' - \code{"start"}
#' - \code{"end"}
#' - \code{"middle"}
#'
#' Use these constants as the \code{position} argument in the \code{\link{create_overlay}} function.
#' 
#' @export
overlay_edge_position <- c("start", "end", "middle")

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
#'      Use \code{\link{create_overlay_style}} function to create the style object of an overlay and be aware of the `enableDefaultOverlayStyle` parameter in the \code{\link{display}} function.
#' @param position The position of the overlay
#'      If the bpmn element where the overlay will be attached is a Shape, use \code{\link{overlay_shape_position}}.
#'      Otherwise, use \code{\link{overlay_edge_position}}.
#'
#' @returns An overlay object
#'
#' @examples
#' # Create an overlay with shape position "top-left"
#' overlay_style <- create_overlay_style(
#'   font_color = 'DarkSlateGray',
#'   font_size = 23,
#'   fill_color = 'MistyRose',
#'   stroke_color = 'Red'
#' )
#'
#' overlay <- create_overlay(
#'   "my-shape-id",
#'   "My Overlay Label",
#'   style = overlay_style,
#'   position = overlay_shape_position[1]
#' )
#'
#' # Create an overlay with edge position "end"
#' overlay_style <- create_overlay_style(
#'   font_color = 'DarkSlateGray',
#'   font_size = 23,
#'   fill_color = 'MistyRose',
#'   stroke_color = 'Red'
#' )
#'
#' overlay <- create_overlay(
#'   "my-edge-id",
#'   "My Overlay Label",
#'   style = overlay_style,
#'   position = overlay_edge_position[2]
#' )
#'
#' @export
create_overlay <- function(elementId, label, style = NULL, position = NULL) {
  if (!is.null(position) && !(position %in% c(overlay_shape_position, overlay_edge_position))) {
    stop(
      paste("Error: position must be:", "\n",
            "\t- NULL", "\n",
            "\t- if the overlay will be attached on a Shape, one of the following values: ", paste(overlay_shape_position, collapse = ", "), "\n",
            "\t- if the overlay will be attached on an Edge, one of the following values: ", paste(overlay_edge_position, collapse = ", ")
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
#' @name create_overlay_style
#' @description
#' When adding an overlay to an existing element in a diagram, it's possible to customize its style.
#'
#' Refer to the \code{style} parameter in the \code{\link{create_overlay}} function for more information.
#'
#' Use this function to create the correct style structure for an overlay.
#'
#' @param font_color The font color of the overlay. Use a custom color string.
#' @param font_size The font size of the overlay. Specify a numeric font size.
#' @param fill_color The color of the background of the overlay. Use a custom color string.
#' @param stroke_color The color of the stroke of the overlay. Use a custom color string.
#'      If you don't want to display a stroke, you can set the color to:
#'      - \code{transparent},
#'      - the same value as for the \code{fill_color}. This increases the \code{padding}/\code{margin}.
#'
#' @returns The style object of the overlay
#'
#' @export
create_overlay_style <- function(font_color = NULL,
                                 font_size = NULL,
                                 fill_color = NULL,
                                 stroke_color = NULL) {
  ret <-
    .not_null_list(
      font = create_font(color = font_color, size = font_size),
      fill = create_fill(fill_color),
      stroke = create_stroke(stroke_color)
    )
}

#' @title Internal function to create the font style of an overlay or a 'BPMN' element
#'
#' @name create_font
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize its font style.
#'  Refer to the \code{font} parameter in the \code{\link{create_overlay_style}} function for more information.
#'  Use this function to create the correct font structure for an overlay.
#'
#' @param color The color of the font of the overlay
#' @param size The size of the font of the overlay
#'
#' @returns The font style object of the overlay
#'
#' @noRd
create_font <- function(color = NULL, size = NULL) {
  ret <-
    .not_null_list(
      color = color,
      size = size
    )
}

#' @title Internal function to create the fill style of an overlay or a 'BPMN' element
#'
#' @name create_fill
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize how it is filled.
#'  Refer to the \code{fill} parameter in the \code{\link{create_overlay_style}} function for more information.
#'  Use this function to create the correct fill structure for an overlay.
#'
#' @param color The color of the background of the overlay
#'
#' @returns The fill style object of the overlay
#'
#' @noRd
create_fill <- function(color) {
  ret <-
    .not_null_list(
      color = color
    )
}

#' @title Internal function to create the stroke style of an overlay or a 'BPMN' element
#'
#' @name create_stroke
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize its stroke. style.
#'  Refer to the \code{stroke.} parameter in the \code{\link{create_overlay_style}} function for more information.
#'  Use this function to create the correct stroke structure for an overlay.
#'
#' @param color The color of the stroke of the overlay
#'
#' @returns The stroke style object of the overlay
#'
#' @noRd
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
