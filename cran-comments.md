# bpmnVisualizationR 0.3.0.9000

This is a resubmission. In this version, we have:

* Fixed the URLs in the DESCRIPTION file.
* Added a new file ([WORDLIST](inst/WORDLIST)) to allow custom words


## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results
❯ On ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Celine Souchet <process.analytics.dev+CRAN@gmail.com>’
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    bpmn (7:182)
    BPMN (3:44, 7:66)
    TypeScript (7:201)

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [5s/16s] NOTE
  Maintainer: ‘Celine Souchet <process.analytics.dev+CRAN@gmail.com>’
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    BPMN (3:44, 7:66)
    TypeScript (7:201)
    bpmn (7:182)

❯ On fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found

0 errors ✔ | 0 warnings ✔ | 3 notes ✖

## Reply from CRAN for the last submission

> Possibly misspelled words in DESCRIPTION:  
>  BPMN (3:44, 7:66)  
>  TypeScript (7:201)  
>  bpmn (7:182)  


These words are spelled correctly. They have been added to the [WORDLIST](inst/WORDLIST) file.