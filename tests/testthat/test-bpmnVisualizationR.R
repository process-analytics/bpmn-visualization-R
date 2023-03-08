test_that("display works", {
  res <- display(
    system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
  )
  
  expect_true(inherits(res, "bpmnVisualizationR"))
  expect_true(inherits(res, "htmlwidget"))
  
  # Be sure that the xml is in the widget
  string <- paste(
    readLines(
      system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
    ),
    collapse = " "
  )
  
  expect_true(grepl(substr(string, 1000, 1010), res$x$bpmnContent))
  expect_true(grepl(substr(string, 2000, 2010), res$x$bpmnContent))
})

test_that("bpmnVisualizationROutput works", {
  res <- bpmnVisualizationROutput("xyz")
  
  expect_true(inherits(res, "shiny.tag.list"))
  expect_true(grepl("bpmnVisualizationR", res))
})


test_that("renderBpmnVisualizationR works", {
  skip_if_not_installed("shiny")
  
  res <- renderBpmnVisualizationR({
    display(
      system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
    )
  })
  
  expect_true(inherits(res, "shiny.render.function"))
  expect_true(inherits(res(), "json"))
})
