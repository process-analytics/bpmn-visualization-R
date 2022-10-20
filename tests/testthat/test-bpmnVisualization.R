test_that("display works", {
  res <- display(
    system.file(
      "examples/Email_Voting.bpmn",
      package = "bpmnVisualization"
    )
  )
  expect_true(
    inherits(
      res,
      "bpmnVisualization"
    )
  )
  expect_true(
    inherits(
      res,
      "htmlwidget"
    )
  )

  # Be sure that the xml is in the widget
  string <- paste(
    readLines(
      system.file(
        "examples/Email_Voting.bpmn",
        package = "bpmnVisualization"
      )
    ),
    collapse = " "
  )

  expect_true(
    grepl(
      substr(string, 1000, 1010),
      res$x$bpmnContent
    )
  )

  expect_true(
    grepl(
      substr(string, 2000, 2010),
      res$x$bpmnContent
    )
  )
})

test_that("bpmnVisualizationOutput works", {
  res <- bpmnVisualizationOutput("xyz")
  expect_true(
    inherits(
      res,
      "shiny.tag.list"
    )
  )

  expect_true(
    grepl(
      "bpmnVisualization",
      res
    )
  )
})


test_that("renderBpmnVisualization works", {
  skip_if_not_installed("shiny")
  res <- renderBpmnVisualization({
    display(
      system.file(
        "examples/Email_Voting.bpmn",
        package = "bpmnVisualization"
      )
    )
  })
  expect_true(
    inherits(
      res,
      "shiny.render.function"
    )
  )
  expect_true(
    inherits(
      res(),
      "json"
    )
  )
})
