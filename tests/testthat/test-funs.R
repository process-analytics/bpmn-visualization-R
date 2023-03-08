test_that("create_overlay works", {
  # Step 1, testing with label and style
  res <- create_overlay(
    "xyz",
    "this",
    "my style"
  )
  expect_true(
    length(res) == 3
  )
  expect_named(
    res,
    c("elementId", "label", "style")
  )
  expect_equal(
    res$elementId,
    "xyz"
  )
  expect_equal(
    res$label,
    "this"
  )
  expect_equal(
    res$style,
    "my style"
  )

  # Step 2, testing with no label, and style
  res <- create_overlay(
    "this",
    NULL,
    "my style"
  )
  expect_true(
    length(res) == 2
  )
  expect_named(
    res,
    c("elementId", "style")
  )
  expect_equal(
    res$elementId,
    "this"
  )
  expect_equal(
    res$style,
    "my style"
  )
  
  # Step 3, testing with label and no style
  res <- create_overlay(
    "this",
    "my label",
    NULL
  )
  expect_true(
    length(res) == 2
  )
  expect_named(
    res,
    c("elementId", "label")
  )
  expect_equal(
    res$elementId,
    "this"
  )
  expect_equal(
    res$label,
    "my label"
  )
})


test_that("build_bpmnContent works", {
  # Step 1, testing xml_doc, no overlays
  res <- build_bpmnContent(
    xml2::read_xml(
      system.file(
        "examples/Email_Voting.bpmn",
        package = "bpmnVisualizationR"
      )
    ), 
    enableDefaultOverlayStyle = TRUE
  )
  expect_true(
    length(res) == 2
  )
  expect_named(
    res,
    c("bpmnContent", "enableDefaultOverlayStyle")
  )
  
  # Step 2, testing xml_doc, overlays
  res <- build_bpmnContent(
    xml2::read_xml(
      system.file(
        "examples/Email_Voting.bpmn",
        package = "bpmnVisualizationR"
      )
    ), 
    enableDefaultOverlayStyle = FALSE,
    overlays = "this"
  )
  expect_true(
    length(res) == 3
  )
  expect_named(
    res,
    c("bpmnContent", "enableDefaultOverlayStyle", "overlays")
  )

  expect_equal(
    res$overlays,
    list("this")
  )

  # Step 3, testing xml_doc, overlays is list
  res <- build_bpmnContent(
    xml2::read_xml(
      system.file(
        "examples/Email_Voting.bpmn",
        package = "bpmnVisualizationR"
      )
    ),
    enableDefaultOverlayStyle = FALSE,
    overlays = list(
      create_overlay("bpmn_element_id_1", "42"),
      create_overlay("bpmn_element_id_2", "9")
    )
  )
  expect_true(
    length(res) == 3
  )
  expect_named(
    res,
    c("bpmnContent", "enableDefaultOverlayStyle", "overlays")
  )

  # Step 4, testing character, no overlays
  res <- build_bpmnContent(
    paste(
      readLines(
        system.file(
          "examples/Email_Voting.bpmn",
          package = "bpmnVisualizationR"
        )
      ),
      collapse = " "
    ),
    enableDefaultOverlayStyle = TRUE
  )
  expect_true(
    length(res) == 2
  )
  expect_named(
    res,
    c("bpmnContent", "enableDefaultOverlayStyle")
  )

  # Step 5, testing character, no overlays
  res <- build_bpmnContent(
    system.file(
      "examples/Email_Voting.bpmn",
      package = "bpmnVisualizationR"
    ),
    enableDefaultOverlayStyle = TRUE
  )
  expect_true(
    length(res) == 2
  )
  expect_named(
    res,
    c("bpmnContent", "enableDefaultOverlayStyle")
  )

  # Step 6, error
  expect_error(
    build_bpmnContent(iris)
  )
})

test_that("not_null_list works", {
  res <- .not_null_list(x = 1, y = NULL)
  expect_true(
    length(res) == 1
  )
  expect_named(
    res,
    c("x")
  )
})