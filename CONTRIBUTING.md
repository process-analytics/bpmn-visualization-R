# Contributing

You are here to help on `bpmn-visualization-R`? Awesome, feel welcome and read the following guidelines in order to know how to contribute, to ask questions and to make `bpmn-visualization-R` such a great tool.

All members of our community are expected to follow our [Code of Conduct](https://github.com/process-analytics/.github/blob/main/CODE_OF_CONDUCT.md). Please make sure you are welcoming and friendly in all of our spaces.

## Contributions 

There are many ways to contribute:

- help people with the questions they ask on the [Github Issues](https://github.com/process-analytics/bpmn-visualization-R/issues)
- submitting bug reports and feature requests in the [Github Issues](https://github.com/process-analytics/bpmn-visualization-R/issues/new)
- improving the README & documentation
- writing code which can be incorporated into `bpmn-visualization-R` itself

### Code and documentation changes guidelines

For all contributions, please respect the following guidelines:

1. If you've noticed a bug or have a feature request, let us know in the [GitHub Issue tracker](https://github.com/process-analytics/bpmn-visualization-R/issues/new )! So we can confirm the bug or approve your feature, and provide feedback, before starting to code :slightly_smiling_face:

2. Do the changes in your own [fork](CONTRIBUTING.md#fork--create-a-branch) of the code

3. Do not commit changes to files that are irrelevant to your feature or bugfix (eg: `.gitignore`).

7. Open a [GitHub Pull Request](CONTRIBUTING.md#open-a-pull-request) with your patches. (**1** pull request = **1** feature or bug)
   We will review your contribution and respond as quickly as possible. Keep in mind that this is an open source project, and it may take us some time to get back to you. Your patience is very much appreciated.

8. If this is your 1st Pull Request, sign the [Contributor License Agreement](CONTRIBUTING.md#sign-the-contributor-license-agreement)

9. Be willing to accept criticism and work on improving your code. 

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on  GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)    

### Fork & create a branch

[Fork bpmn-visualization-R](https://help.github.com/articles/fork-a-repo) and create a branch with a descriptive name. 

A good branch name would be (where issue #25 is the ticket you're working on): **25-customize_overlays**

```sh
git checkout -b 25-customize_overlays
```

### Commit in the Pull Request
There is no convention for the commit message in the Pull Request.
The most important part is the title of the Pull Request, because:
- Everyone must use Pull Request, no direct commit allowed on master branch
- The commits of a Pull Request are almost always squashed
- The title of the Pull Request is used as proposal for the maintainer merging the Pull Request

### Open a Pull Request

At this point, you should switch back to your master branch and make sure it's up to date with `bpmn-visualization-R`
`master` branch:

```sh
git remote add upstream git@github.com:process-analytics/bpmn-visualization-R.git
git checkout master
git pull upstream master
```

Then update your feature branch from your local copy of master, and push it!

```sh
git checkout 25-customize_overlays
git rebase master
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

If a maintainer asks you to [rebase](http://git-scm.com/book/en/Git-Branching-Rebasing) your PR, they're saying that a lot of code has changed, and that you need to update your branch so it's easier to merge.

Here's the suggested workflow:

```sh
git checkout 25-customize_overlays
git pull --rebase upstream master
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

### bpmn-visualization-js update

The  [bpmn-visualization-js](https://github.com/process-analytics/bpmn-visualization-js) dependency is automatically updated by the [Update BPMN Visualization version](.github/workflows/update_bpmn_visualization_version.yml) worklow when a new version of this library is released.

This generates a new Pull Request and notifies the reviewers.

___
⚠️⚠️⚠️ _**Manual procedure - Only if the job does NOT work!**_  ⚠️⚠️⚠️

- Change [bpmn-visualization.min.js](inst/htmlwidgets/lib/bpmn-visualization/bpmn-visualization.min.js). The file can be retrieved from [jsdelivr](https://www.jsdelivr.com/package/npm/bpmn-visualization) or [unpkg](https://unpkg.com/browse/bpmn-visualization/).
- Update the version of `bpmn-visualization` in [bpmnVisualization.yaml](inst/htmlwidgets/bpmnVisualization.yaml)
___

## Maintainers

### Merging a PR (maintainers only)

A PR can only be merged into master by a maintainer, if all of these conditions are met:

* It is passing CI.
* It has been approved by at least two maintainers. If it was a maintainer who opened the PR, only one extra approval is needed.
* It has no requested changes.
* It is up to date with current master.

### Release process

Maintainers need to perform the following actions **in the order described here** to push out a release.

#### Verify the version in files

Check that the files are using the version to be released:
- [DESCRIPTION](./DESCRIPTION)
- [README](./README.md)

Create a new PR and merge it, if some files require changes. The PR/commit message should be `[RELEASE] Set version to x.y.z`.

#### GitHub issues and milestones update

**Note:** we always put issues related to a version in a Milestone whose name matches the version.

- Ensure the name of the milestone used for the new release version matches the name of the tag/version that is going to be released. Renamed it if needed.
- Clean this opened milestone if some issues are still opened (move them to a new one or discard milestone from them).
- Close the milestone.
- Create a new milestone for the next version if it does not already exist.

#### Prepare the GitHub Release Notes

- Open [github releases](https://github.com/process-analytics/bpmn-visualization-R/releases)
- Create a new draft release and name it `Next` (the name is not relevant and will be replaced automatically later).
  This ensures that development can continue without impacting the writing of the content of the in progress release. That way,
  if a PR is merged, `release-drafter` will update the `Next` draft release keeping the in-progress release untouched.
- The draft release for the newly tagged version should already exist:
   - [release-drafter](https://github.com/release-drafter/release-drafter) creates or updates draft release for the
     next version each time a pull request is merged to the `master` branch.
   - create a new release if it is missing or rename the existing one to match.
- Assign the new tag as release target and save the draft (this should have already been managed by `release-drafter`)
- Ensure that `This is a pre-release` is unchecked (except if we are releasing alpha, beta, rc, ...)
- In the release description (check previous releases as a source of inspiration), put screenshots/gif of the new features.
- At any time, you can save the draft.

#### Release on GitHub (tag)

- Open the draft release note in [github releases](https://github.com/process-analytics/bpmn-visualization-R/releases)
- Verify the tag version as the same as the release note.
- Published the release **only when you are done** with the release content. 

#### Publish the new version on CRAN

**NOTE**: we cannot publish on CRAN for now, see [#10](https://github.com/process-analytics/bpmn-visualization-R/issues/10)

- Pull the new version created by the release workflow: `git pull origin`
- Ensure you are on the last tag locally: `git checkout vX.Y.Z`
- Build the source package. Please read [the CRAN Submission policies first](https://cran.r-project.org/web/packages/policies.html#Submission)
  - Solution 1: Build the source package with RStudio 
    - Open the project in RStudio
    - On the **Build** tab, click on **More** > **Build Source Package**
    - Go to the parent folder of the project. You should find a file named like `bpmnVisualization_X.Y.Z.tgz`.
  - Solution 2.
    - from the project directory, run `R CMD build .
    - You should find a file named like `bpmnVisualization_X.Y.Z.tgz` in the project directory.
- Do the actual submission
  - Fill all the fields of this [web form](https://xmpalantir.wu.ac.at/cransubmit/), and load `bpmnVisualization_X.Y.Z.tgz` file.
  - Submit

### Communicate about the release

#### Twitter

You can use this template:

> 📣 BPMN Visualization - R package {version} is out! 🎉
>
> ===> some short description here <===
>
> #bpmnvisualization #bpmn #visualization #R #RLang #programming #opensource
>
> https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v{version}

