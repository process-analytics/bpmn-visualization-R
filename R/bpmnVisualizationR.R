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
#'      Use the \code{create_overlay} function to create an overlay object with content and a relative position.
#' @param enableDefaultOverlayStyle If no style is set on an overlay, and this parameter is set to \code{TRUE}, the default style will be applied to the overlay.
#'      By default, \code{enableDefaultOverlayStyle} is set to \code{TRUE}.
#' @param width A fixed width for the widget (in CSS units). 
#'      The default value is \code{NULL}, which results in intelligent automatic sizing based on the widget's container.
#' @param height A fixed height for the widget (in CSS units). 
#'      The default value is \code{NULL}, which results in intelligent automatic sizing based on the widget's container.
#' @param elementId The ID of the 'HTML' element to enclose the widget.
#'      Use an explicit element ID for the widget (rather than an automatically generated one). 
#'      This is useful if you have other 'JavaScript' that needs to explicitly
#'      discover and interact with a specific widget instance.
#'
#' @returns A \code{bpmnVisualizationR} widget that will intelligently print itself into 'HTML' in a variety of contexts
#'      including the 'R' console, within 'R Markdown' documents, and within 'Shiny' output bindings.
#'
#' @examples
#' # Load the BPMN file
#' bpmn_file <- system.file("examples/Order_Management.bpmn", package = "bpmnVisualizationR")
#'
#' # Display the BPMN diagram
#' bpmnVisualizationR::display(bpmn_file, width='auto', height='auto')
#'
#' # Display the BPMN diagram featuring overlays and their default style/position
#' taskStyle <- bpmnVisualizationR::create_style(
#'   font = bpmnVisualizationR::create_font(color = 'DarkSlateGray', size = 23),
#'   fill = bpmnVisualizationR::create_fill(color = 'MistyRose'),
#'   stroke = bpmnVisualizationR::create_stroke(color = 'Red')
#' )
#'
#' flowStyle <- bpmnVisualizationR::create_style(
#'   font = bpmnVisualizationR::create_font(color = 'WhiteSmoke', size = 19),
#'   fill = bpmnVisualizationR::create_fill(color = 'Teal'),
#'   stroke = bpmnVisualizationR::create_stroke(color = 'SpringGreen')
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
#' # Display the BPMN diagram featuring overlays, but exclude their default style/position
#' overlays <- list(
#'   bpmnVisualizationR::create_overlay("start_event_1_1", "42", position = "middle-left"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_1", "42", flowStyle, "end"),
#'   bpmnVisualizationR::create_overlay("task_1_1", "9", taskStyle, "bottom-right"),
#'   bpmnVisualizationR::create_overlay("sequence_flow_1_2", "8",  position = 'start')
#' )
#' bpmnVisualizationR::display(
#'   bpmn_file, 
#'   overlays, 
#'   enableDefaultOverlayStyle=FALSE, 
#'   width='auto', 
#'   height='auto'
#' )
#'
#' @seealso \code{\link{create_overlay}} to create an overlay
#'
#' @import htmlwidgets
#' @import xml2
#'
#' @export
display <- function(
  bpmnXML,
  overlays = NULL,
  enableDefaultOverlayStyle = TRUE,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  x <- build_bpmnContent(
    bpmnXML,
    overlays = overlays,
    enableDefaultOverlayStyle = enableDefaultOverlayStyle
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

#' @title Shiny output binding for the \code{bpmnVisualizationR} 'HTML' widget
#'
#' @name bpmnVisualizationR-shiny-output
#' @description
#' Helper to create output function for using the \code{bpmnVisualizationR} 'HTML' widget within 'Shiny' applications and interactive 'Rmd' documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#'
#' @returns An output function that enables the use of the \code{bpmnVisualizationR} widget within 'Shiny' applications.
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

#' @title 'Shiny' render binding for the \code{bpmnVisualizationR} 'HTML' widget
#'
#' @rdname bpmnVisualizationR-shiny-render
#' @description
#' Helper to create render function for using the \code{bpmnVisualizationR} 'HTML' widget within 'Shiny' applications and interactive 'Rmd' documents.
#'
#' @param expr An expression that generates a \code{bpmnVisualizationR} 'HTML' widget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @returns A render function that enables the use of the \code{bpmnVisualizationR} widget within 'Shiny' applications.
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
