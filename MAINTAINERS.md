# Maintainers

The information provided here are for the maintainers of the project. Contributors should read the [Contributing Guide](./CONTRIBUTING.md) instead.


## Merging a Pull Request

A PR can only be merged into master by a maintainer, if all of these conditions are met:

- The CI Checks are passing.
- It has been approved by at least two maintainers. If it was a maintainer who opened the PR, only one extra approval is needed.
- It has no requested changes.
- It is up to date with current `main` branch.

## Release process

Maintainers need to perform the following actions **in the order described here** to push out a release.

### Verify the version in files

**NOTE**: this is a very manual process today. For improvements, see [#131](https://github.com/process-analytics/bpmn-visualization-R/issues/131)

Check that the files are using the version to be released:
- [DESCRIPTION](./DESCRIPTION)
- [README](./README.md)

Create a new PR (it must have the `skip-changelog` label as we don't want it to appear in the release notes) and merge it,
if some files require changes. The PR/commit message should be `[RELEASE] Set version to x.y.z`.

### GitHub issues and milestones update

**Note:** we always put issues related to a version in a Milestone whose name matches the version.

- Ensure the name of the milestone used for the new release version matches the name of the tag/version that is going to be released. Renamed it if needed.
- Clean this opened milestone if some issues are still opened (move them to a new one or discard milestone from them).
- Close the milestone.
- Create a new milestone for the next version if it does not already exist.

### Prepare the GitHub Release Notes

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

### Release on GitHub (tag)

- Open the draft release note in [github releases](https://github.com/process-analytics/bpmn-visualization-R/releases)
- Verify the tag version as the same as the release note.
- Published the release **only when you are done** with the release content.

### Use a development version

**NOTE**: this is a very manual process today. For improvements, see [#131](https://github.com/process-analytics/bpmn-visualization-R/issues/131)

Update the [DESCRIPTION](./DESCRIPTION) file to use a development version (for more explanations, see the [R documentation](https://r-pkgs.org/release.html#post-release):
- bump the current version. For instance, if the released version was `0.3.0`, bump it to `0.3.1`
- add a postfix to the version to state that it is a development version. For instance, `0.3.1.9000`

Create a new PR (it must have the `skip-changelog` label as we don't want it to appear in the release notes) and merge it.
The PR/commit message should be `[INFRA] Set the development version to x.y.z`.

### Publish the new version on CRAN

**NOTES**:
- CRAN publishing is `in-progress`, see [#10](https://github.com/process-analytics/bpmn-visualization-R/issues/10)
- This is a very manual process today. For improvements, see [#11](https://github.com/process-analytics/bpmn-visualization-R/issues/11)

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

## Communicate about the release

**NOTE**: this is a very manual process today. For improvements, see [#130](https://github.com/process-analytics/bpmn-visualization-R/issues/130)

### Twitter

You can use this template:

> 📣 bpmn-visualization R package {version} is out! 🎉
>
> ===> some short description here <===
>
> #bpmnvisualization #bpmn #visualization #R #RLang #programming #opensource
>
> https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v{version}

### Discord

Channel: [news](https://discord.com/channels/1011911769607913562/1024329159033499780)

You can use this template:

> 📣 bpmn-visualization R package {version} is out! 🎉
>
> ===> some short description here <===
>
> https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v{version}
