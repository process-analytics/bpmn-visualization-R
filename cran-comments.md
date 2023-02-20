# bpmnVisualizationR 0.3.2

This is a new submission. In this version, we have:

* Updated `bpmn-visualization` TypeScript library from 0.29.2 to 0.31.0.

## Test environments
<RESULT OF check_for_cran()>

## R CMD check results
<RESULT OF check_for_cran()>

## Response to CRAN for last submission

> <CITATION>

# bpmnVisualizationR 0.3.2

This is a new submission. In this version, we have:

* Added single quotes for package names, software names and API, in `title` and `description` on the [DESCRIPTION](DESCRIPTION) file.
* Added single quotes for package names, software names and API, in the documentation of the methods of this package.

## Test environments

- R-hub windows-x86_64-devel (r-devel). Platform: Windows Server 2022, R-devel, 64 bit
- R-hub ubuntu-gcc-release (r-release). Platform: Ubuntu Linux 20.04.1 LTS, R-release, GCC
- R-hub fedora-clang-devel (r-devel). Platform: Fedora Linux, R-devel, clang, gfortran

## R CMD check results

There were no ERRORs or WARNINGs.

As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.
Also, we cannot change that `Tidy` is not on the path or update `Tidy` on the external Fedora Linux server.

❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Celine Souchet <process.analytics.dev+CRAN@gmail.com>'
  
  New submission
  
❯ On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [6s/25s] NOTE
  Maintainer: ‘Celine Souchet <process.analytics.dev+CRAN@gmail.com>’
  
  New submission
  
❯ On fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found

0 errors ✔ | 0 warnings ✔ | 4 notes ✖

## Response to CRAN for last submission

> If there are references describing the methods in your package, please
> add these in the description field of your DESCRIPTION file in the form
> authors (year) <doi:...>
> authors (year) <arXiv:...>
> authors (year, ISBN:...)
> or if those are not available: <https:...>
> with no space after 'doi:', 'arXiv:', 'https:' and angle brackets for
> auto-linking. (If you want to add a title as well please put it in quotes: "Title")

There is no reference describing the methods in this package.

> Please always write package names, software names and API (application
> programming interface) names in single quotes in title and description.
> e.g: --> 'TypeScript'
> Please note that package names are case-sensitive.

✅ Done on the [DESCRIPTION](DESCRIPTION) file and the documentation of the methods of this package.

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
