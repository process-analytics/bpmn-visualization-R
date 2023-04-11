# Maintainers

The information provided here are for the maintainers of the project. Contributors should read the [Contributing Guide](./CONTRIBUTING.md) instead.


## Merging a Pull Request

A PR can only be merged into master by a maintainer, if all of these conditions are met:

- The CI Checks are passing.
- It has been approved by at least two maintainers. If it was a maintainer who opened the PR, only one extra approval is needed.
- It has no requested changes.
- It is up-to-date with current `main` branch.

## Release process

Maintainers need to perform the following actions **in the order described here** to push out a release.

### ⚠️⚠️ First decide whether to publish on CRAN ⚠️⚠️

The CRAN policy states the following:
> Submitting updates should be done responsibly and with respect for the volunteers’ time. Once a package is established (which may take several rounds), “no more than every 1–2 months” seems appropriate. 
ℹ️ For more information, see https://r-pkgs.org/release.html#cran-policies and https://cran.r-project.org/web/packages/policies.html.

But on our end, we can provide more frequent releases. In this case, do not publish to CRAN. 
The new version will only be available via an installation from GitHub.


### Preparing a CRAN submission with `rhub`

**NOTES**: required only if we decide to publish to CRAN

Before starting a release, check that the output of the `rhub` package is stored in [cran-comments.md](cran-comments.md) (the most recent output is at the top of the file, and the oldest at the bottom).
If this is not the case, you must perform the following steps.

#### First installation
```R
install.packages("rhub")
library(rhub)
```

Locally, configure the email address of the maintainer (described in [DESCRIPTION](DESCRIPTION)):
  - retrieve the token you previously received by email
  - call the [validate_email.html](https://r-hub.github.io/rhub/reference/validate_email.html) by passing the maintainer email and the token 

If you don't have any token, `rhub` will prompt you to generate a token (on the first check).

#### Check
Follow this procedure: https://r-hub.github.io/rhub/articles/rhub.html#prepare-a-cran-submission.

```R
cran_prep <- check_for_cran()
```

⚠️ Locally, you can only see one run of the environment.
To see the other one, you can get the URLs from the top of the local run, and open it on a browser.

Example:
```R
─  Preparing build, see status at
https://builder.r-hub.io/status/bpmnVisualizationR_X.Y.Z.tar.gz-A
https://builder.r-hub.io/status/bpmnVisualizationR_X.Y.Z.tar.gz-B
https://builder.r-hub.io/status/bpmnVisualizationR_X.Y.Z.tar.gz-C
```

#### Post processing
In [cran-comments.md](cran-comments.md):
- At the top, add this template:
```markdown
# bpmnVisualizationR <X.Y.Z>.9000

This is a <re-submission | new submission>. In this version, we have:

* <NEW CHANGE>

## Test environments
<RESULT OF check_for_cran()>

## R CMD check results
<RESULT OF check_for_cran()>

## Response to CRAN for last submission

> <CITATION>
```
- Choose if this is a `re-submission` or a `new submission`.
- Add the new change of this version.
- Copy and paste the output of the following command, after receiving the emails for all environments on the maintainer's [email address](DESCRIPTION) from `check_for_cran()`:
```R
cran_prep$cran_summary()
```
- In the "Test environments" paragraph, also provides the details of the environment as mentioned in the build status email.
For instance, add "Platform: Windows Server 2022, R-devel, 64 bit".
- Remove all `Version contains large components (X.Y.Z.9000)"` and update the counter of detected `NOTE` in the summary of all environments
- If this is a `re-submission`, copy and paste the result for the last CRAN submission, and answer to false NOTES.  
Otherwise, remove the part:
```markdown
## Response to CRAN for last submission

> <CITATION>
```


### GitHub issues and milestones update

**Note:** we always put issues related to a version in a Milestone whose name matches the version.

- Ensure the name of the milestone used for the new release version matches the name of the tag/version that is going to be released. Renamed it if needed.
- Clean this opened milestone if some issues are still opened (move them to a new one or discard milestone from them).
- Close the milestone.
- Create a new milestone for the next version if it does not already exist.

### Prepare the GitHub Release Notes

- Open [GitHub releases](https://github.com/process-analytics/bpmn-visualization-R/releases)
- Create a new draft release and name it `Next` (the name is not relevant and will be replaced automatically later).
  This ensures that development can continue without impacting the writing of the content of the in progress release. That way,
  if a PR is merged, `release-drafter` will update the `Next` draft release keeping the in-progress release untouched.
- The draft release for the newly tagged version should already exist:
  - [release-drafter](https://github.com/release-drafter/release-drafter) creates or updates draft release for the
    next version each time a pull request is merged to the `master` branch.
  - create a new release if it is missing or rename the existing one to match.
- Ensure that `This is a pre-release` is unchecked (except if we are releasing alpha, beta, rc, ...)

### Initiate the Release

- Open the [Release GitHub Actions](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/release.yml)
- Click on the 'Run workflow' dropdown located on the right side of the page
- Provide parameter value for New version type (default is patch, but you can choose one of the [major | minor | patch])
- Click on the button 'Run workflow'
- Make sure job execution was successful by checking the status
- The new git tag should have been created and available on GitHub

___

### Manual procedure

⚠️⚠️⚠️ _**Only if the GitHub job that release this repository fails after manual re-run!**_  ⚠️⚠️⚠️

#### Verify the version in files

Check that the files are using the version to be released:
- [DESCRIPTION](./DESCRIPTION)
- [index](./index.md) (used in the HTML documentation)
- [README](./README.md)

Create a new PR (it must have the `skip-changelog` label as we don't want it to appear in the release notes) and merge it,
if some files require changes. The PR/commit message should be `chore(release): set version to x.y.z`.

Once this is done, tag manually with the following command (**do not forget** to replace `x.y.z` by the actual version):
``` 
git tag -a vx.y.z -m "chore(release): x.y.z"
git push && git push --tags
```

#### Use a development version

Add the `.9000` suffix to the `Version` field in the [DESCRIPTION](./DESCRIPTION) file to indicate that this is a development version (for more explanations, see the [R documentation](https://r-pkgs.org/release.html#post-release)).  
For instance, if the released version was `0.3.0`, the `Version` field in the `DESCRIPTION` file should be `0.3.O.9000`.

Create a new PR (it must have the `skip-changelog` label as we don't want it to appear in the release notes) and merge it.
The PR/commit message should be `chore(release): set the development version to x.y.z.9000`.

___

#### Publish the GitHub Release Notes

- Open the draft release note in [GitHub releases](https://github.com/process-analytics/bpmn-visualization-R/releases)
- In the release description (check previous releases as a source of inspiration)
  - If the bpmn-visualization TypeScript library was updated, add a phrase about it (for example, see [Release 0.3.0](https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v0.3.0) for instance.): `The bpmnVisualizationR package now uses [bpmn-visualization@0.29.0](https://github.com/process-analytics/bpmn-visualization-js/releases/tag/v0.29.0).`
  - Put screenshots/gif of the new features.
- If the package is not published on CRAN (see the 1st paragraph of the release process), please specify this by adding a sentence in bold! 
The sentence should explain why the new version is not available on CRAN. It should also remind people to install it from GitHub.
- At any time, you can save the draft.
- **Only when you are done**:
  - Assign the tag of the new version as release target and save the draft (doing it as later as possible ensure that `release-drafter` doesn't interfer with the writing of the Release Notes)
  - Publish the release.

### Publish the new version on CRAN

**NOTES**: required only if we decide to publish to CRAN

#### Generate and retrieve the source package

It conforms to [the CRAN Submission policies first](https://cran.r-project.org/web/packages/policies.html#Submission)

- Open [GitHub Actions](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/R-CMD-check.yaml)
- Find the execution related to the newly created tag
  - Choose the **tag that has just been created**, do not use the main branch!
  - If it doesn't exist, click on the 'Run workflow' dropdown located on the right side of the page
    - Remember to choose the tag that has just been created, **do not use the main branch!**
    - Click on the button 'Run workflow' and wait for the end of the execution
- Download the source package
  - in the artifact section, choose the source package built with the `r-release` version, as shown in the screenshot below 👇
  - unzip the artifact to retrieve the tar.gz file that will submit be later

![source package selection](./doc/maintainers/release_cran_source_package.png)


#### Do the submission

- Fill all the fields of this [web form](https://xmpalantir.wu.ac.at/cransubmit/), and load `bpmnVisualizationR_X.Y.Z.tar.gz` file.
  - upload the package `tar.gz` source previously retrieved
  - for all required fields, use the value from the DESCRIPTION file of the `tar.gz` source (in particular, the name and email of the maintainer of the package are available at the end of the file)
- Submit
- **Don't forget to confirm the submission**:
  - A few minutes after the submission, the package manager should have received an email asking to confirm the submission. The email object looks like `CRAN Submission of bpmnVisualizationR 0.3.0 - Confirmation Link`
  - Confirm the submission by clicking on the link provided in the email
  - The submission is only effective when a new email is received from CRAN confirming the submission. The email object looks like `CRAN Submission of bpmnVisualizationR 0.3.0`

## Communicate about the release

- Open [GitHub Actions](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/announce-new-release.yml)
- Click on the 'Run workflow' dropdown located on the right side of the page
- Provide parameter values for _version_ and _description_
- Click on the button 'Run workflow'
- Make sure job execution was successful by checking the status
- If all is good, you should see a new tweet on [ProcessAnalyti1](https://twitter.com/ProcessAnalyti1) and a new message on the [news](https://discord.com/channels/1011911769607913562/1024329159033499780) channel of Process Analytics server on Discord.

___
⚠️⚠️⚠️ _**Only if the [jobs](https://github.com/process-analytics/bpmn-visualization-R/actions/workflows/announce-new-release.yml) does NOT work!**_  ⚠️⚠️⚠️
### Twitter

You can use this template:

> 📣 bpmnVisualizationR {version} is out! 🎉
>
> ===> some short description here <===
>
> #bpmnvisualization #bpmn #visualization #R #RLang #programming #opensource
>
> https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v{version}

### Discord

Channel: [news](https://discord.com/channels/1011911769607913562/1024329159033499780)

You can use this template:

> 📣 bpmnVisualizationR {version} is out! 🎉
>
> ===> some short description here <===
>
> https://github.com/process-analytics/bpmn-visualization-R/releases/tag/v{version}

⚠️⚠️⚠️ _**End of the manual steps**_ ⚠️⚠️⚠️
___
