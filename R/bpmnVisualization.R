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

#' @title Display BPMN diagram in an HTML Widget
#'
#' @name display
#' @description Display BPMN diagram based on BPMN definition in XML format
#'
#' @param bpmnXML A file name or xml document or string in BPMN XML format
#' @param overlays An element or a list of elements to be added to the diagram's existing elements.
#'      Use overlay function to create an overlay object with content and relative position.
#' @param width Fixed width for widget (in css units). The default is \code{NULL}, which results in intelligent automatic sizing based on the widget's container.
#' @param height Fixed height for widget (in css units). The default is \code{NULL}, which results in intelligent automatic sizing based on the widget's container.
#' @param elementId The id of the HTML element to enclose the widget.
#'      Use an explicit element ID for the widget (rather than an automatically
#'      generated one). Useful if you have other JavaScript that needs to explicitly
#'      discover and interact with a specific widget instance.
#'
#' @returns A \code{bpmn-visualization} Widget that will intelligently print itself into HTML in a variety of contexts
#'      including the R console, within R Markdown documents, and within Shiny output bindings.
#'
#' @examples
#' # Load the BPMN file
#' bpmn_file <- system.file("examples/Order_Management.bpmn", package = "bpmnVisualization")
#'
#' # Display the BPMN diagram
#' bpmnVisualization::display(bpmn_file, width='auto', height='auto')
#'
#' # Display the BPMN diagram with overlays
#' overlays <- list(
#'   create_overlay("start_event_1_1", "42"),
#'   create_overlay("sequence_flow_1_1", "42"),
#'   create_overlay("task_1_1", "9")
#' )
#' bpmnVisualization::display(bpmn_file, overlays, width='auto', height='auto')
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
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  x <- build_bpmnContent(
    bpmnXML,
    overlays = overlays
  )
  # create widget
  htmlwidgets::createWidget(
    name = "bpmnVisualization",
    x,
    width = width,
    height = height,
    package = "bpmnVisualization",
    elementId = elementId
  )
}

#' @title Shiny output binding for the \code{bpmn-visualization} HTML widget
#'
#' @name bpmnVisualization-shiny-output
#' @description
#' Helper to create output function for using the \code{bpmn-visualization} HTML widget within Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#'
#' @returns An output function that enables the use of the \code{bpmn-visualization} widget within Shiny applications.
#'
#' @export
bpmnVisualizationOutput <- function(
  outputId,
  width = "100%",
  height = "400px"
) {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "bpmnVisualization",
    width,
    height,
    package = "bpmnVisualization"
  )
}

#' @title Shiny render binding for the \code{bpmn-visualization} HTML widget
#'
#' @rdname bpmnVisualization-shiny-render
#' @description
#' Helper to create render function for using the \code{bpmn-visualization} HTML widget within Shiny applications and interactive Rmd documents.
#'
#' @param expr An expression that generates a \code{bpmn-visualization} HTML widget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @returns A render function that enables the use of the \code{bpmn-visualization} widget within Shiny applications.
#'
#' @export
renderBpmnVisualization <- function(
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
    bpmnVisualizationOutput,
    env,
    quoted = TRUE
  )
}
