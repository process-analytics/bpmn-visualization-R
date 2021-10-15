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

#' display
#'
#' Display BPMN diagram based on BPMN definition in XML format
#'
#' @param bpmnXML A file name or xml document or string in BPMN XML format
#' @param overlays An element or a list of elements to be added to the diagram's existing elements.
#'      Use overlay function to create an overlay object with content and relative position.
#' @param width The width used to display the widget
#' @param height The height used to display the widget
#' @param elementId The id of the HTML element to enclose the widget
#'
#' @import htmlwidgets
#' @import xml2
#'
#' @export
display <- function(bpmnXML, overlays = NULL, width = NULL, height = NULL, elementId = NULL) {
  # load bpmn content
  if (inherits(bpmnXML, "xml_document")) {
    bpmnContent <- as.character(bpmnXML)
  } else if (inherits(bpmnXML, "character")) {
    if (substring(bpmnXML, 1, 38) == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>") {
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

  # widget parameters
  x <- list(bpmnContent = bpmnContent)
  if(length(overlays)) {
    # In case the user passes a single parameter as overlays (instead of a list), we wrap it into a list so the js can work
    x$overlays <- if (is.list(overlays[[1]])) {
      overlays
    } else {
      list(overlays)
    }
  }

  # create widget
  htmlwidgets::createWidget(
    name = 'bpmnVisualization',
    x,
    width = width,
    height = height,
    package = 'bpmnVisualization',
    elementId = elementId
  )
}

#' create_overlay
#'
#' An overlay can be added to existing elements in the diagram.
#' See \code{overlays} argument in \code{\link{bpmnVisualization}} function.
#' Use this structure to create correct overlay structure.
#'
#' @param elementId The bpmn element id to which the overlay will be attached
#' @param label HTML element to use as an overlay
#'
#' @return An overlay object
#'
#' @export
create_overlay <- function(elementId, label) {
  ret <-
    .not_null_list(
      elementId = elementId,
      label = label
    )
}

#' Shiny bindings for bpmnVisualization
#'
#' Output and render functions for using bpmnVisualization within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a bpmnVisualization
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name bpmnVisualization-shiny
#'
#' @export
bpmnVisualizationOutput <- function(outputId, width = '100%', height = '400px') {
  htmlwidgets::shinyWidgetOutput(outputId, 'bpmnVisualization', width, height, package = 'bpmnVisualization')
}

#' @rdname bpmnVisualization-shiny
#' @export
renderBpmnVisualization <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, bpmnVisualizationOutput, env, quoted = TRUE)
}



.not_null_list <- function(...) {
  ret <- list(...)
  ret[lengths(ret) == 0] <- NULL
  ret
}
