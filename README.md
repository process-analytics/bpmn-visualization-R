<h1 align="center">BPMN Visualization - R Package</h1>
<div align="center">
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
`bpmn` widget accepts a BPMN file (or an XML document):
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

### Initialize the R package and load the BPMN diagram
```r
bpmnVisualization::display(bpmn_file)
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