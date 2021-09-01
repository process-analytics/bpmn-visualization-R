<h1 align="center">BPMN Visualization - R Package</h1>
<div align="center">
    <p align="center"> <img title="Email Voting BPMN Diagram with overlays" src="img/readme.png" alt="Email Voting BPMN Diagram with overlays"></p>
    <p align="center">
        <a href="https://github.com/process-analytics/bpmn-visualization-R/releases">
          <img alt="GitHub release (latest by date including pre-releases)" src="https://img.shields.io/github/v/release/process-analytics/bpmn-visualization-R?label=changelog&include_prereleases"> 
        </a>
        <a href="https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/R-CMD-check.yaml">
          <img alt="Build" src="https://github.com/process-analytics/bpmn-visualization-R/workflows/R-CMD-check/badge.svg"> 
        </a>
        <br>
        <a href="CONTRIBUTING.md">
          <img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-ff69b4.svg?style=flat-square"> 
        </a> 
        <a href="CODE_OF_CONDUCT.md">
          <img alt="Contributor Covenant" src="https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg"> 
        </a> 
        <a href="LICENSE">
          <img alt="License" src="https://img.shields.io/github/license/process-analytics/bpmn-visualization-R?color=blue"> 
        </a>
    </p>
</div>  
<br>

This project is an R interface to the [BPMN Visualization](https://github.com/process-analytics/bpmn-visualization-js) library.

## ♻️ Usage
### Installation
Install from GitHub:
```r
devtools::install_github("process-analytics/bpmn-visualization-R")
library(bpmnVisualization)
```

### Load the BPMN file
`bpmnVisualization` accepts a BPMN file (or an XML document):

Load an BPMN example provided by the package

The diagrams files are taken from the [BPMN 2.0 examples non-normative machine readable files](https://www.omg.org/spec/BPMN/2.0)
- Email_Voting.bpmn
- Nobel_Prize_Process.bpmn
- Order_Process_for_Pizza_V4.bpmn
- Travel_Booking.bpmn

```r
bpmn_file <- system.file("examples/Email_Voting.bpmn", package = "bpmnVisualization")
```

Or
```r
bpmn_file <- file.choose()
```

Or
```r
bpmn_file <- "path_to_bpmn_file"
```

Or
```r
bpmn_file <- "<?xml version="1.0" encoding="UTF-8"?> ...xml_content"
```

### Display the BPMN diagram
```r
bpmnVisualization::display(bpmn_file)
```


### Display the BPMN diagram with overlays

```r
overlays <- list(create_overlay("bpmn_element_id_1", "42"), create_overlay("bpmn_element_id_2", "9"))
bpmnVisualization::display(bpmn_file, overlays)
```


### Integrate in Shiny Applications

The following displays a BPMN diagram provided as example by the package with an overlay on top of a BPMN element.

```r
# Install and load packages
install.packages("shiny")
library(shiny)
devtools::install_github("process-analytics/bpmn-visualization-R")
library(bpmnVisualization)

displayBpmn <- function() {
    bpmn_file <- system.file("examples/Travel_Booking.bpmn", package = "bpmnVisualization")
    overlays <- list(bpmnVisualization::create_overlay("_6-203", "9"))
    bpmnVisualization::display(bpmn_file, overlays)
}

ui <- shinyUI(fluidPage(
    titlePanel("Display bpmn diagrams with execution data"),
    bpmnVisualizationOutput('bpmnContainer')
  )
)

server = function(input, output) {
    # renderBpmnVisualization is the R bridge function to the html widgets
    output$bpmnContainer <- renderBpmnVisualization({ displayBpmn() })
}

shinyApp(ui, server)
```

## 🔧 Contributing

To contribute to `bpmn-visualization-R`, fork and clone this repository locally and commit your code on a separate branch. \
Please write tests for your code before opening a pull-request.

You can find more detail in our [Contributing guide](CONTRIBUTING.md). Participation in this open source project is subject to a [Code of Conduct](CODE_OF_CONDUCT.md).

✨ A BIG thanks to all our contributors 🙂

## ⚒️ Development
### Installation
```r
devtools::install()
```

## 📃 License

`bpmn-visualization-R` is released under the [Apache 2.0](LICENSE) license. \
Copyright &copy; from 2021, Bonitasoft S.A.
