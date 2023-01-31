# bpmnVisualizationR 0.3.1

This is a new submission. In this version, we have:

* Corrected the URLs and removed the `LazyData` field in the [DESCRIPTION](DESCRIPTION) file.
* Added a new file ([WORDLIST](inst/WORDLIST)) to allow custom words with `spelling` package.


## Test environments
- R-hub windows-x86_64-devel (r-devel). Platform: Windows Server 2022, R-devel, 64 bit
- R-hub ubuntu-gcc-release (r-release). Platform: Ubuntu Linux 20.04.1 LTS, R-release, GCC
- R-hub fedora-clang-devel (r-devel). Platform: Fedora Linux, R-devel, clang, gfortran

**Notes**:
- the tests presented here were run on [rhub](https://r-hub.github.io/rhub/articles/rhub.html#prepare-a-cran-submission).
- additional tests were also run on [GitHub Actions](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/R-CMD-check.yaml).

## R CMD check results

❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Celine Souchet <process.analytics.dev+CRAN@gmail.com>’
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    bpmn (7:182)
    BPMN (3:44, 7:66)
    TypeScript (7:201)

0 errors ✔ | 0 warnings ✔ | 3 notes ✖

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [6s/25s] NOTE
  Maintainer: ‘Celine Souchet <process.analytics.dev+CRAN@gmail.com>’
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    BPMN (3:44, 7:66)
    TypeScript (7:201)
    bpmn (7:182)

0 errors ✔ | 0 warnings ✔ | 3 notes ✖

## Response to CRAN for last submission

**Note**: the previous submission was done for version 0.3.1 of bpmnVisualizationR (commit 0cb72a6)

> Possibly misspelled words in DESCRIPTION:  
>  BPMN (3:44, 7:66)  
>  TypeScript (7:201)  
>  bpmn (7:182)  


These words are spelled correctly. They have been added to the [WORDLIST](inst/WORDLIST) file.
