#' @title The overlay positions on `Shape`
#'
#' @description
#' To specify the position when creating an overlay object that will be attached to BPMN `Shape` elements in the diagram.
#'
#' @details
#' Use these constants as the `position` argument in the [`create_overlay`] function.
#'
#' **Positions**:
#'  * `top-left`
#'  * `top-right`
#'  * `top-center`
#'  * `bottom-left`
#'  * `bottom-right`
#'  * `bottom-center`
#'  * `middle-left`
#'  * `middle-right`
#'
#' @seealso [`create_overlay`]
#' 
#' @examples
#' # Create an overlay at the top-left corner of a shape
#' overlay <- create_overlay(elementId = 1, label = "My label", position = overlay_shape_position[1])
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

#' @title The overlay positions on `Edge`
#'
#' @description
#' To specify the position when creating an overlay object that will be attached to BPMN `Edge` elements in the diagram.
#' 
#' @details
#' Use these constants as the `position` argument in the [`create_overlay`] function.
#'
#' **Positions**:
#'  * `start`
#'  * `end`
#'  * `middle`
#'
#' @seealso [`create_overlay`]
#'
#' @examples
#' # Create an overlay at the starting point of an edge
#' overlay <- create_overlay(elementId = 1, label = "My label", position = overlay_edge_position[1])
#' 
#' @export
overlay_edge_position <- c("start", "end", "middle")

#' @title Create an overlay
#'
#' @name create_overlay
#' @description 
#' An overlay can be added to existing elements in the diagram.
#' 
#' See the `overlays` argument in the [`display`] function.
#' 
#' Use this function to create the correct overlay structure.
#' 
#' @param elementId The bpmn element id to which the overlay will be attached
#' @param label 'HTML' element to use as an overlay
#' @param style The style of the overlay.
#'      Use [`create_overlay_style`] function to create the style object of an overlay and be aware of the `enableDefaultOverlayStyle` parameter in the [`display`] function.
#' @param position The position of the overlay
#'      If the bpmn element where the overlay will be attached is a Shape, use [`overlay_shape_position`].
#'      Otherwise, use [`overlay_edge_position`].
#'
#' @returns An overlay object
#'
#' @examples
#' # Example 1: Create an overlay with shape position "top-left"
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
#' # Example 2: Create an overlay with edge position "end"
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
#' Refer to the `style` parameter in the [`create_overlay`] function for more information.
#'
#' Use this function to create the correct style structure for an overlay.
#'
#' @param font_color The font color of the overlay. It can be any HTML color name or HEX code.
#' @param font_size The font size of the overlay. Specify a number in px.
#' @param fill_color The color of the background of the overlay. It can be any HTML color name or HEX code.
#' @param stroke_color The color of the stroke of the overlay. It can be any HTML color name or HEX code.\cr
#' If you don't want to display a stroke, you can set the color to:
#' * `transparent`,
#' * the same value as for the `fill_color`. This increases the `padding`/`margin`.
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

#' @title Create the style for BPMN element
#'
#' @name create_element_style
#'
#' @description Internal function to create the correct style structure for the 'BPMN' element.
#'
#' @param elementIds The IDs of the BPMN elements to style.
#' @param stroke_color The stroke color for the element.
#'  It can be any HTML color name or HEX code, or special keywords.
#' @param stroke_width The stroke width for the element, in pixels (1 to 50).
#' * If the set value is less than 1, the used value is 1.
#' * If the set value is greater than 50, the used value is 50.
#' * To hide the stroke, set the `stroke_color` property to `none`.
#' @param stroke_opacity The stroke opacity for the element, ranging from 0 to 100.
#' @param font_color The font color for the element.
#'  It can be any HTML color name or HEX code, or special keywords.
#' @param font_family The font family for the element.
#' @param font_size The font size for the element, in pixels.
#' @param font_bold Should the font be bold? (default: `FALSE`)
#' @param font_italic Should the font be italic? (default: `FALSE`)
#' @param font_strike_through Should the font have a strike-through style? (default: `FALSE`)
#' @param font_underline Should the font be underlined? (default: `FALSE`)
#' @param font_opacity The font opacity for the element, ranging from 0 to 100.
#' @param opacity The opacity for the element, ranging from 0 to 100.
#' 
#' @return A list representing the style for the specified BPMN elements.
#'
#' @details
#' # Special keywords
#' \describe{
#'    \item{`default`}{
#'      \itemize{
#'        \item This keyword allows you to reset a style property of the BPMN element to its initial value.
#'        \item When applied to color properties, it bypasses the color specified in the 'BPMN' source if 'BPMN in Color' support is enabled. Instead, it uses the color defined in the default style of the 'BPMN' element..
#'      }
#'    }
#'    \item{`inherit`}{Applies the value from the immediate parent element.}
#'    \item{`none`}{No color (used to hide strokes). Not available for `font_color`.}
#'    \item{`swimlane`}{Applies the value from the nearest parent element with type `ShapeBpmnElementKind.LANE` or `ShapeBpmnElementKind.POOL`.}
#' }
#' 
#' # Note
#' ## Opacity properties
#' * If the set value is less than 0, the used value is 0.
#' * If the set value is greater than 100, the used value is 100.
#' 
#' ## ⚠️⚠️⚠️ `stroke_width` property ⚠️⚠️⚠️
#'  Changing the stroke width of Activities may be misleading, as the default stroke widths have a meaning according to the 'BPMN' Specification.\cr
#'  For example, updating the stroke width of a task using the same value as the default stroke width of a Call Activity can be confusing.\cr
#'  In this case, you should also change another property, such as the stroke color, to allow the user to differentiate between them.
#'  
#' @keywords internal
create_element_style <- function(elementIds,
                                 stroke_color = NULL,
                                 stroke_width = NULL,
                                 stroke_opacity = NULL,
                                 font_color = NULL,
                                 font_family = NULL,
                                 font_size = NULL,
                                 font_bold = NULL,
                                 font_italic = NULL,
                                 font_strike_through = NULL,
                                 font_underline = NULL,
                                 font_opacity = NULL,
                                 opacity = NULL) {
  if(!is.list(elementIds)) {
    stop("elementIds must be a list!!")
  }
  
  style <- .not_null_list(
    stroke = create_stroke(
      color = stroke_color,
      width = stroke_width,
      opacity = stroke_opacity
    ),
    font = create_font(
      color = font_color,
      family = font_family,
      size = font_size,
      isBold = font_bold,
      isItalic = font_italic,
      isStrikeThrough = font_strike_through,
      isUnderline = font_underline,
      opacity = font_opacity
    ),
    opacity = opacity
  )
  ret <- list(elementIds = elementIds, style = style)
}


#' @title Create the style for BPMN edge
#'
#' @name create_edge_style
#'
#' @description
#'  Use this function to create the correct style structure for the edge.
#'
#' @inherit create_element_style params sections
#' @return A list representing the style for the BPMN edge.
#' @examples
#' # Create a style with a blue stroke and a bold, red font.
#' edge_style <- create_edge_style(
#'   elementIds = list('id_1', 'id_2'),
#'   stroke_color = "blue",
#'   stroke_width = 2,
#'   font_color = "red",
#'   font_bold = TRUE
#' )
#' @export
create_edge_style <- function(elementIds,
                              stroke_color = NULL,
                              stroke_width = NULL,
                              stroke_opacity = NULL,
                              font_color = NULL,
                              font_family = NULL,
                              font_size = NULL,
                              font_bold = NULL,
                              font_italic = NULL,
                              font_strike_through = NULL,
                              font_underline = NULL,
                              font_opacity = NULL,
                              opacity = NULL) {
  if (all(is.null(
    c(
      stroke_color,
      stroke_width,
      stroke_opacity,
      font_color,
      font_family,
      font_size,
      font_bold,
      font_italic,
      font_strike_through,
      font_underline,
      font_opacity,
      opacity
    )
  ))) {
    stop(
      "At least one style property (e.g., stroke_color, font_color, opacity, ...) must be provided!!"
    )
  }
  
  ret <- create_element_style(
    elementIds = elementIds,
    stroke_color = stroke_color,
    stroke_width = stroke_width,
    stroke_opacity = stroke_opacity,
    font_color = font_color,
    font_family = font_family,
    font_size = font_size,
    font_bold = font_bold,
    font_italic = font_italic,
    font_strike_through = font_strike_through,
    font_underline = font_underline,
    font_opacity = font_opacity,
    opacity = opacity
  )
  return(ret)
}


#' @title Create the style for BPMN shape
#'
#' @name create_shape_style
#'
#' @description
#'  Use this function to create the correct style structure for the shape.
#'
#' @inherit create_element_style params sections
#' @param fill_color The fill color for the shape 
#'  It can be any HTML color name or HEX code, special keywords, or a gradient create with [`create_gradient_fill`].
#' @param fill_opacity The fill opacity for the shape, ranging from 0 to 100.
#'
#' @return A list representing the style for the BPMN shape.
#' @seealso \code{\link{create_gradient_fill}}
#'
#' @examples
#' # Create a style with a blue stroke, red font, and green fill color.
#' shape_style <- create_shape_style(
#'   elementIds = list('id_1', 'id_2'),
#'   stroke_color = "blue",
#'   stroke_width = 2,
#'   font_color = "red",
#'   fill_color = "green"
#' )
#' @export
create_shape_style <- function(elementIds,
                               stroke_color = NULL,
                               stroke_width = NULL,
                               stroke_opacity = NULL,
                               font_color = NULL,
                               font_family = NULL,
                               font_size = NULL,
                               font_bold = NULL,
                               font_italic = NULL,
                               font_strike_through = NULL,
                               font_underline = NULL,
                               font_opacity = NULL,
                               opacity = NULL,
                               fill_color = NULL, 
                               fill_opacity = NULL) {
  if (is.null(stroke_color) &&
      is.null(stroke_width) &&
      is.null(stroke_opacity) &&
      is.null(font_color) &&
      is.null(font_family) &&
      is.null(font_size) &&
      is.null(font_bold) &&
      is.null(font_italic) &&
      is.null(font_strike_through) &&
      is.null(font_underline) &&
      is.null(font_opacity) &&
      is.null(opacity) &&
      is.null(fill_color) && is.null(fill_opacity)) {
    stop(
      "At least one style property (e.g., stroke_color, font_color, fill_opacity, opacity, ...) must be provided!!"
    )
  }
  
  res <- create_element_style(
    elementIds = elementIds,
    stroke_color = stroke_color,
    stroke_width = stroke_width,
    stroke_opacity = stroke_opacity,
    font_color = font_color,
    font_family = font_family,
    font_size = font_size,
    font_bold = font_bold,
    font_italic = font_italic,
    font_strike_through = font_strike_through,
    font_underline = font_underline,
    font_opacity = font_opacity,
    opacity = opacity
  )

  if (!is.null(fill_color) || !is.null(fill_opacity) ) {
    res$style$fill <- create_fill(color = fill_color, opacity = fill_opacity)
  }
  return(res)
}

#' @title Internal function to create the font style of an overlay or a 'BPMN' element
#'
#' @name create_font
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize its font style.
#'  Refer to the `font` parameter in the [`create_overlay_style`] function for more information.
#'  Use this function to create the correct font structure for an overlay.
#'
#' @param color The color of the font of the overlay
#' @param size The size of the font of the overlay
#'
#' @returns The font style object of the overlay
#'
#' @noRd
create_font <- function(color = NULL, size = NULL, family = NULL, isBold = NULL, isItalic = NULL, isStrikeThrough = NULL, isUnderline = NULL, opacity = NULL) {
  ret <-
    .not_null_list(
      color = color,
      size = size,
      family = family,
      opacity = opacity,
      isBold = isBold,
      isItalic = isItalic,
      isStrikeThrough = isStrikeThrough,
      isUnderline = isUnderline
    )
}

#' @title Internal function to create the fill style of an overlay or a 'BPMN' element
#'
#' @name create_fill
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize how it is filled.
#'  Refer to the `fill` parameter in the [`create_overlay_style`] function for more information.
#'  Use this function to create the correct fill structure for an overlay.
#'
#' @param color The color of the background of the overlay
#'
#' @returns The fill style object of the overlay
#'
#' @noRd
create_fill <- function(color = NULL, opacity = NULL) {
  ret <-
    .not_null_list(
      color = color,
      opacity = opacity
    )
}

#' @title Create a gradient fill style for an element
#'
#' @name create_gradient_fill
#'
#' @description Create a gradient fill style for an element.
#'
#' @param direction The direction of the gradient (e.g., \code{left-to-right}, \code{right-to-left}, \code{bottom-to-top}, \code{top-to-bottom}).
#'  Taking the example of bottom-to-top, this means that the start color is at the bottom of the paint pattern and the end color is at the top, with a gradient between them.
#' @param start_color The starting color of the gradient. It can be any HTML color name or HEX code, as well as special keywords such as `inherit`, `none`, `swimlane`.
#' @param end_color The ending color of the gradient. It can be any HTML color name or HEX code, as well as special keywords such as `inherit`, `none`, `swimlane`.
#'
#' @return A gradient fill style object.
#'
#' @export
create_gradient_fill <- function(direction, start_color, end_color) {
  ret <- .not_null_list(
    direction = direction,
    startColor = start_color,
    endColor = end_color
  )
}

#' @title Internal function to create the stroke style of an overlay or a 'BPMN' element
#'
#' @name create_stroke
#' @description
#' - Overlay:
#'  When adding an overlay to an existing element in a diagram, it's possible to customize its stroke style.
#'  Refer to the `stroke` parameter in the [`create_overlay_style`] function for more information.
#'  Use this function to create the correct stroke structure for an overlay.
#'
#' @param color The color of the stroke of the overlay
#'
#' @returns The stroke style object of the overlay
#'
#' @noRd
create_stroke <- function(color = NULL, width = NULL, opacity = NULL) {
  ret <-
    .not_null_list(
      color = color,
      width = width,
      opacity = opacity
    )
}

#' @description Internal function to build the 'htmlwidget' content
#'
#' @inheritParams display
#' @returns A list
#'
#' @noRd
build_bpmnContent <- function(
  bpmnXML,
  overlays = NULL,
  enableDefaultOverlayStyle,
  bpmnElementStyles = NULL
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

  if (length(bpmnElementStyles)) {
    if(is.list(bpmnElementStyles[[1]]) && !is.null(bpmnElementStyles[[1]]$elementIds) && !is.null(bpmnElementStyles[[1]]$style)) {
      x$bpmnElementStyles <- bpmnElementStyles
    } else {
      stop("bpmnElementStyles must be a list of <elementIds | style> !!")
    }
  }
  return(x)
}

.not_null_list <- function(...) {
  ret <- list(...)
  ret[lengths(ret) == 0] <- NULL
  ret
}
