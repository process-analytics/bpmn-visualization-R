# Contributing

You are here to help on `bpmnVisualizationR`? Awesome, feel welcome and read the following guidelines in order to know how to contribute, to ask questions and to make `bpmnVisualizationR` such a great tool.

All members of our community are expected to follow our [Code of Conduct](https://github.com/process-analytics/.github/blob/main/CODE_OF_CONDUCT.md). Please make sure you are welcoming and friendly in all of our spaces.

## Contributions 

There are many ways to contribute:

- help people with the questions they ask on the [GitHub Issues](https://github.com/process-analytics/bpmn-visualization-R/issues)
- submitting bug reports and feature requests in the [GitHub Issues](https://github.com/process-analytics/bpmn-visualization-R/issues/new)
- improving the README & documentation
- writing code which can be incorporated into `bpmnVisualizationR` itself

### Code and documentation changes guidelines

For all contributions, please respect the following guidelines:

1. If you've noticed a bug or have a feature request, let us know in the [GitHub Issue tracker](https://github.com/process-analytics/bpmn-visualization-R/issues/new )! So we can confirm the bug or approve your feature, and provide feedback, before starting to code :slightly_smiling_face:

2. Do the changes in your own [fork](CONTRIBUTING.md#fork--create-a-branch) of the code

3. Do not commit changes to files that are irrelevant to your feature or bugfix (eg: `.gitignore`).

4. Open a [GitHub Pull Request](CONTRIBUTING.md#open-a-pull-request) with your patches. (**1** pull request = **1** feature or bug)
   We will review your contribution and respond as quickly as possible. Keep in mind that this is an open source project, and it may take us some time to get back to you. Your patience is very much appreciated.

5. If this is your 1st Pull Request, sign the [Contributor License Agreement](CONTRIBUTING.md#sign-the-contributor-license-agreement)

6. Be willing to accept criticism and work on improving your code. 

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on  GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)    

### Fork & create a branch

[Fork the bpmn-visualization-R repository](https://help.github.com/articles/fork-a-repo) and create a branch with a descriptive name. 

A good branch name would be (where issue #25 is the ticket you're working on): **25-customize_overlays**

```sh
git checkout -b 25-customize_overlays
```

### Commit in the Pull Request
There is no convention for the commit message in the Pull Request.
The most important part is the title of the Pull Request, because:
- Everyone must use Pull Request, no direct commit allowed on main branch
- The commits of a Pull Request are almost always squashed
- The title of the Pull Request is used as proposal for the maintainer merging the Pull Request

### Open a Pull Request

At this point, you should switch back to your main branch and make sure it's up-to-date with the `main` branch of the `bpmn-visualization-R` repository:

```sh
git remote add upstream git@github.com:process-analytics/bpmn-visualization-R.git
git checkout main
git pull upstream main
```

Then update your feature branch from your local copy of main, and push it!

```sh
git checkout 25-customize_overlays
git rebase main
git push --set-upstream origin 25-customize_overlays
```

Finally, go to GitHub and [make a Pull Request](https://help.github.com/articles/creating-a-pull-request) with labels :smile:
For the title, follow the directives of the Pull Request template.
Add a screenshot of the rendering of your examples/bpmn-file. 

:warning: We care about quality. So your PR won't be merged until all tests pass.

### Sign the Contributor License Agreement

By signing the CLA, we acknowledge that your contribution is accepted as it and that you cannot be held responsible for
any impacts on its integration. You then grant us the right to modify and distribute your code without restrictions. We
ask this of all contributors in order to assure our users of the origin and continuing existence of the code.

When you contribute to the project on GitHub with a new pull request, the [cla-assistant bot](https://cla-assistant.io/)
will evaluate whether you have signed the CLA. If required, the bot will comment on the pull request, including a link
to this system to accept the agreement.

You only need to sign the CLA once or when the CLA terms have changed.

### Keeping your Pull Request updated

If a maintainer asks you to [rebase](http://git-scm.com/book/en/Git-Branching-Rebasing) your PR, they're saying that a lot of code has changed, and that you need to update your branch, so it's easier to merge.

Here's the suggested workflow:

```sh
git checkout 25-customize_overlays
git pull --rebase upstream main
git push --force-with-lease 25-customize_overlays
```

At this point, you're ready to make your changes! Feel free to ask for help. Everyone is a beginner at first :smile_cat:

## ⚒️ Development
### Installation
```r
devtools::install()
```

### Regenerate the R documentation
The **R documentation** (.Rd) format is generated from the function comments thanks to [roxygen2](https://roxygen2.r-lib.org/). \
To regenerate this documentation after function comment updating, run this command:
```r
devtools::document()
```

### Generate the HTML documentation (site)

The HTML documentation is generated with [pkgdown](https://pkgdown.r-lib.org).

If you need to test locally changes in the configuration or content of this documentation, install `pkgdown` following the [official documentation](https://pkgdown.r-lib.org/#installation).

**Note**: on Ubuntu, you may encounter errors during the installation of `pkgdown`. In particular, the installation of some dependent packages may fail:
- `systemfonts`: run `sudo apt -y install libfontconfig1-dev` (see [systemfonts#35](https://github.com/r-lib/systemfonts/issues/35#issuecomment-633560151) )
- `textshapping`: `run sudo apt -y install libharfbuzz-dev libfribidi-dev` 

Once `pkgdown` is installed, you can generate the HTML documentation quickly with this command:
```
pkgdown::build_site(devel = TRUE, lazy = TRUE, preview = FALSE)
```
For more details about the available options, see [the official documentation](https://pkgdown.r-lib.org/reference/build_site.html).

### bpmn-visualization TypeScript library update

The [bpmn-visualization](https://github.com/process-analytics/bpmn-visualization-js) dependency is automatically updated by the [Update bpmn-visualization version](.github/workflows/update-bpmn-visualization-version.yml) workflow when a new version of this library is released.

This generates a new Pull Request and notifies the reviewers.

___
⚠️⚠️⚠️ _**Manual procedure - Only if the job does NOT work!**_  ⚠️⚠️⚠️

- Change [bpmn-visualization.min.js](inst/htmlwidgets/lib/bpmn-visualization/bpmn-visualization.min.js). The file can be retrieved from [jsdelivr](https://www.jsdelivr.com/package/npm/bpmn-visualization) or [unpkg](https://unpkg.com/browse/bpmn-visualization/).
- Update the version of `bpmn-visualization` TypeScript library in [bpmnVisualizationR.yaml](inst/htmlwidgets/bpmnVisualizationR.yaml)
___

