#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
bpmnVisualization <- function(bpmn_xml, width = NULL, height = NULL, elementId = NULL) {
  # load bpmn content
  if (inherits(bpmn_xml, "xml_document")) {
    bpmnContent <- as.character(bpmn_xml)
  } else if (inherits(bpmn_xml, "character")) {
    if (substring(bpmn_xml, 1, 38) == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>") {
      # this must be a string corresponding to the BPMN content of a file
      bpmnContent <- bpmn_xml
    } else {
      # this must be a file name
      xml <- xml2::read_xml(bpmn_xml)
      bpmnContent <- as.character(xml)
    }
  } else {
    stop("bpmn_xml must be a absolute path of BPMN file or the string of the BPMN content !!")
  }

  # widget parameters
  x <- bpmnContent

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
