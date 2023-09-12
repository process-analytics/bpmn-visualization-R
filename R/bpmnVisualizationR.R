# Copyright 2021 Bonitasoft S.A.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' @title Display 'BPMN' diagram in an 'HTML' Widget
#'
#' @name display
#' @description Display 'BPMN' diagram based on 'BPMN' definition in 'XML' format
#'
#' @param bpmnXML A file name or 'XML' document or string in 'BPMN' 'XML' format
#' @param overlays An element or a list of elements to be added to the diagram's existing elements.
#'      Use the [`create_overlay`] function to create an overlay object with content and a relative position.
#' @param enableDefaultOverlayStyle If no style is set on an overlay, and this parameter is set to `TRUE`, the default style will be applied to the overlay.
#'      By default, `enableDefaultOverlayStyle` is set to `TRUE`.
#' @param bpmnElementStyles a list of existing elements with their style to apply.
#'      Use the [`create_shape_style`] or [`create_edge_style`] functions to create the style of 'BPMN' elements.
#' @param width A fixed width for the widget (in CSS units).
#'      The default value is `NULL`, which results in intelligent automatic sizing based on the widget's container.
#' @param height A fixed height for the widget (in CSS units).
#'      The default value is `NULL`, which results in intelligent automatic sizing based on the widget's container.
#' @param elementId The ID of the 'HTML' element to enclose the widget.
#'      Use an explicit element ID for the widget (rather than an automatically generated one).
#'      This is useful if you have other 'JavaScript' that needs to explicitly
#'      discover and interact with a specific widget instance.
#'
#' @returns A `bpmnVisualizationR` widget that will intelligently print itself into 'HTML' in a variety of contexts
#'      including the 'R' console, within 'R Markdown' documents, and within 'Shiny' output bindings.
#'
#' @examples
#' # Load the BPMN file
#' bpmn_file <- system.file("examples/Order_Management.bpmn", package = "bpmnVisualizationR")
#'
#' # Example 1: Display the BPMN diagram
#' bpmnVisualizationR::display(bpmn_file, width='auto', height='auto')
#'
#' # Example 2: Display the BPMN diagram featuring overlays with their default positions and styles
#' overlays <- list(
#'   bpmnVisualizationR::create_overlay("start_event_1_1", "42"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_1", "42"),
#'   bpmnVisualizationR::create_overlay("task_1_1", "9"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_2", "8"),
#'   bpmnVisualizationR::create_overlay("call_activity_1_1", "7")
#' )
#'
#' bpmnVisualizationR::display(
#'   bpmn_file,
#'   overlays,
#'   width='auto',
#'   height='auto'
#' )
#'
#' # Example 3: Display the BPMN diagram featuring overlays using custom styles and positions
#' taskStyle <- bpmnVisualizationR::create_overlay_style(
#'   font_color = 'DarkSlateGray',
#'   font_size = 23,
#'   fill_color = 'MistyRose',
#'   stroke_color = 'Red'
#' )
#'
#' flowStyle <- bpmnVisualizationR::create_overlay_style(
#'   font_color = 'WhiteSmoke',
#'   font_size = 19,
#'   fill_color = 'Teal',
#'   stroke_color = 'SpringGreen'
#' )
#'
#' overlays <- list(
#'   bpmnVisualizationR::create_overlay("start_event_1_1", "42", position = "middle-left"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_1", "42", flowStyle, "end"),
#'   bpmnVisualizationR::create_overlay("task_1_1", "9", taskStyle),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_2", "8"),
#'   bpmnVisualizationR::create_overlay("call_activity_1_1", "7")
#' )
#' bpmnVisualizationR::display(bpmn_file, overlays, width='auto', height='auto')
#'
#' # Example 4: Display the BPMN diagram featuring overlays, 
#' # but exclude their default styles and positions
#' overlays <- list(
#'   bpmnVisualizationR::create_overlay("start_event_1_1", "42", position = "middle-left"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_1", "42", flowStyle, "end"),
#'   bpmnVisualizationR::create_overlay("task_1_1", "9", taskStyle, "bottom-right"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_2", "8",  position = 'start')
#' )
#'
#' bpmnVisualizationR::display(
#'   bpmn_file,
#'   overlays,
#'   enableDefaultOverlayStyle=FALSE,
#'   width='auto',
#'   height='auto'
#' )
#'
#' # Example 5: Display the BPMN diagram featuring styling for BPMN elements
#' bpmnElementStyles <- list(
#'   bpmnVisualizationR::create_shape_style(
#'     elementIds = list("call_activity_1_1"),
#'     stroke_color = 'RoyalBlue',
#'     font_color = 'DarkOrange',
#'     font_family = 'Arial',
#'     font_size = 12,
#'     font_bold = TRUE,
#'     font_italic = TRUE,
#'     font_strike_through = TRUE,
#'     font_underline = TRUE,
#'     opacity = 75,
#'     fill_color = 'Yellow',
#'     fill_opacity = 50
#'   ),
#'   bpmnVisualizationR::create_edge_style(
#'     elementIds = list("sequence_flow_1_4"),
#'     stroke_color = 'DeepPink',
#'     stroke_width = 3,
#'     stroke_opacity = 70,
#'     font_color = 'ForestGreen',
#'     font_family = 'Courier New',
#'     font_size = 14,
#'     font_bold = TRUE,
#'     font_italic = TRUE,
#'     font_strike_through = FALSE,
#'     font_underline = FALSE,
#'     font_opacity = 80,
#'     opacity = 80
#'   )
#' )
#'
#' bpmnVisualizationR::display(
#'   bpmn_file,
#'   bpmnElementStyles = bpmnElementStyles,
#'   width='auto',
#'   height='auto'
#' )
#'
#' @seealso 
#' * [`create_overlay`] to create an overlay
#' * [`create_shape_style`] to create the structure style for the shape
#' * [`create_edge_style`] to create the structure style for the edge
#'
#' @import htmlwidgets
#' @import xml2
#'
#' @export
display <- function(
  bpmnXML,
  overlays = NULL,
  enableDefaultOverlayStyle = TRUE,
  bpmnElementStyles = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  x <- build_bpmnContent(
    bpmnXML,
    overlays = overlays,
    enableDefaultOverlayStyle = enableDefaultOverlayStyle,
    bpmnElementStyles = bpmnElementStyles
  )
  # create widget
  htmlwidgets::createWidget(
    name = "bpmnVisualizationR",
    x,
    width = width,
    height = height,
    package = "bpmnVisualizationR",
    elementId = elementId
  )
}

#' @title Shiny output binding for the `bpmnVisualizationR` 'HTML' widget
#'
#' @name bpmnVisualizationR-shiny-output
#' @description
#' Helper to create output function for using the `bpmnVisualizationR` 'HTML' widget within 'Shiny' applications and interactive 'Rmd' documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like `100%`, `400px`, `auto`) or a number,
#'  which will be coerced to a string and have `px` appended.
#'
#' @returns An output function that enables the use of the `bpmnVisualizationR` widget within 'Shiny' applications.
#'
#' @export
bpmnVisualizationROutput <- function(
  outputId,
  width = "100%",
  height = "400px"
) {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "bpmnVisualizationR",
    width,
    height,
    package = "bpmnVisualizationR"
  )
}

#' @title 'Shiny' render binding for the `bpmnVisualizationR` 'HTML' widget
#'
#' @rdname bpmnVisualizationR-shiny-render
#' @description
#' Helper to create render function for using the `bpmnVisualizationR` 'HTML' widget within 'Shiny' applications and interactive 'Rmd' documents.
#'
#' @param expr An expression that generates a `bpmnVisualizationR` 'HTML' widget
#' @param env The environment in which to evaluate `expr`.
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This
#'   is useful if you want to save an expression in a variable.
#'
#' @returns A render function that enables the use of the `bpmnVisualizationR` widget within 'Shiny' applications.
#'
#' @export
renderBpmnVisualizationR <- function(
  expr,
  env = parent.frame(),
  quoted = FALSE
) {
  # Checking that shiny is installed
  rlang::check_installed("shiny")
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(
    expr,
    bpmnVisualizationROutput,
    env,
    quoted = TRUE
  )
}
