#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
bpmnVisualization <- function(message, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
  )

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
bpmnVisualizationOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'bpmnVisualization', width, height, package = 'bpmnVisualization')
}

#' @rdname bpmnVisualization-shiny
#' @export
renderBpmnVisualization <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, bpmnVisualizationOutput, env, quoted = TRUE)
}
