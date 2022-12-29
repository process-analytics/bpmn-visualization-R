<!-- This page is processed by pkgdown to create the home page of the HTML documentation -->

# bpmnVisualizationR

<!-- badges: start -->
[![R-CMD-check](https://github.com/process-analytics/bpmn-visualization-R/workflows/R-CMD-check/badge.svg)](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


<!-- duplicated with README.md -->
`bpmnVisualizationR` is an R package for visualizing process execution data on BPMN diagrams, using overlays, style customization and interactions.

It is made possible by [htmlwidgets](http://www.htmlwidgets.org/), which provides an easy-to-use framework for bringing together R and the [bpmn-visualization](https://github.com/process-analytics/bpmn-visualization-js) TypeScript library.
<!-- END OF duplicated with README.md -->


<!-- duplicated with README.md -->
## Installation

To install a dedicated version (available versions can be found in the [GitHub releases page](https://github.com/process-analytics/bpmn-visualization-R/releases)), run:
```r
devtools::install_github("process-analytics/bpmn-visualization-R@v0.2.2")
```

Or install the development version:
```r
devtools::install_github("process-analytics/bpmn-visualization-R")
```

Then, make the library available to the current R project:
```r
library(bpmnVisualizationR)
```
<!-- END OF duplicated with README.md -->


## Usage

You first need to retrieve the content of the BPMN diagram. Once you are done, you can pass it to the display function
that will render it.

```r
bpmnVisualizationR::display(bpmn_content)
```

Read `?display` for more details.


## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/process-analytics/.github/blob/main/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
