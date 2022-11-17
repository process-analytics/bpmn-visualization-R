\name{bpmnVisualization-package}
\alias{bpmnVisualization-package}
\alias{bpmnVisualization}
\docType{package}
\title{
\packageTitle{bpmnVisualization}
}
\description{
\packageDescription{bpmnVisualization}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{bpmnVisualization}
\packageIndices{bpmnVisualization}
}
\author{
\packageAuthor{bpmnVisualization}

Maintainer: \packageMaintainer{bpmnVisualization}
}

\examples{
\donttest{
# Load the BPMN file
bpmn_file <- system.file("examples/Order_Management.bpmn", package = "bpmnVisualization")

# Display the BPMN diagram
display(bpmn_file, width='auto', height='auto')
}
}

\section{More examples}{
  See \url{https://github.com/process-analytics/bpmn-visualization-R#readme} for more usage examples.
}

\section{Support}{
  Use \url{https://github.com/process-analytics/bpmn-visualization-R/issues} for bug reports
}
