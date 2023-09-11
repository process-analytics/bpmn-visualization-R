describe("create_overlay works", {
  test_that("with label, style and position", {
    res <- create_overlay("xyz", "this", "my style", "start")

    expect_true(length(res) == 4)
    expect_named(res, c("elementId", "label", "style", "position"))
    expect_equal(res$elementId, "xyz")
    expect_equal(res$label, "this")
    expect_equal(res$style, "my style")
    expect_equal(res$position, "start")
  })

  test_that("with no label, style and position", {
    res <- create_overlay("this", NULL, "my style", "middle")

    expect_true(length(res) == 3)
    expect_named(res, c("elementId", "style", "position"))
    expect_equal(res$elementId, "this")
    expect_equal(res$style, "my style")
    expect_equal(res$position, "middle")
  })

  test_that("with label, no style, and position", {
    res <- create_overlay("this", "my label", NULL, "top-center")

    expect_true(length(res) == 3)
    expect_named(res, c("elementId", "label", "position"))
    expect_equal(res$elementId, "this")
    expect_equal(res$label, "my label")
    expect_equal(res$position, "top-center")
  })

  test_that("with label, style, and no position", {
    res <- create_overlay("this", "my label", "my style", NULL)

    expect_true(length(res) == 3)
    expect_named(res, c("elementId", "label", "style"))
    expect_equal(res$elementId, "this")
    expect_equal(res$label, "my label")
    expect_equal(res$style, "my style")
  })

  test_that("throws an exception when position is not valid", {
    expect_error(
      create_overlay("this", "my label", "my style", position = "invalid_position"),
      "position must be"
    )
  })
})

describe("create_overlay_style works", {
  test_that("with font, fill, and stroke", {
    res <- create_overlay_style(
      font_color = "my font color",
      font_size = "my font size",
      fill_color = "my fill color",
      stroke_color = "my stroke color"
    )

    expect_type(res, "list")
    expect_length(res, 3)
    expect_named(res, c("font", "fill", "stroke"))

    expect_equal(res$font, list(color = "my font color", size = "my font size"))
    expect_equal(res$fill, list(color = "my fill color"))
    expect_equal(res$stroke, list(color = "my stroke color"))
  })

  test_that("with no font, fill, and stroke", {
    res <- create_overlay_style(fill_color = "my fill color", stroke_color = "my stroke color")

    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("fill", "stroke"))

    expect_equal(res$fill, list(color = "my fill color"))
    expect_equal(res$stroke, list(color = "my stroke color"))
  })

  test_that("with font, no fill, and stroke", {
    res <- create_overlay_style(
      font_color = "my font color",
      font_size = "my font size",
      fill_color = NULL,
      stroke_color = "my stroke color"
    )

    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("font", "stroke"))

    expect_equal(res$font, list(color = "my font color", size = "my font size"))
    expect_equal(res$stroke, list(color = "my stroke color"))
  })

  test_that("with font, fill, and no stroke", {
    res <- create_overlay_style(
      font_color = "my font color",
      font_size = "my font size",
      fill_color = "my fill color",
      stroke_color = NULL
    )

    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("font", "fill"))

    expect_equal(res$font, list(color = "my font color", size = "my font size"))
    expect_equal(res$fill, list(color = "my fill color"))
  })

  test_that("with only font_color", {
    res <- create_overlay_style(font_color = "my font color")

    expect_type(res, "list")
    expect_length(res, 1)
    expect_named(res, c("font"))

    expect_equal(res$font, list(color = "my font color"))
  })

  test_that("with only font_size", {
    res <- create_overlay_style(font_size = "my font size")

    expect_type(res, "list")
    expect_length(res, 1)
    expect_named(res, c("font"))

    expect_equal(res$font, list(size = "my font size"))
  })

  test_that("with only fill_color", {
    res <- create_overlay_style(fill_color = "my fill color")

    expect_type(res, "list")
    expect_length(res, 1)
    expect_named(res, c("fill"))

    expect_equal(res$fill, list(color = "my fill color"))
  })

  test_that("with only stroke_color", {
    res <- create_overlay_style(stroke_color = "my stroke color")

    expect_type(res, "list")
    expect_length(res, 1)
    expect_named(res, c("stroke"))

    expect_equal(res$stroke, list(color = "my stroke color"))
  })

  test_that("with no arguments", {
    res <- create_overlay_style()

    expect_type(res, "list")
    expect_length(res, 0)
  })

})

describe("build_bpmnContent works", {
  test_that("with xml_doc and no overlays", {
    res <- build_bpmnContent(
      xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = TRUE
    )

    expect_true(length(res) == 2)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle"))
  })

  test_that("with xml_doc and overlays", {
    res <- build_bpmnContent(
      xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = FALSE,
      overlays = "this"
    )

    expect_true(length(res) == 3)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle", "overlays"))

    expect_equal(res$overlays, list("this"))
  })

  test_that("with xml_doc and overlays is list", {
    res <- build_bpmnContent(
      xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = FALSE,
      overlays = list(
        create_overlay("bpmn_element_id_1", "42"),
        create_overlay("bpmn_element_id_2", "9")
      )
    )

    expect_true(length(res) == 3)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle", "overlays"))
  })

  test_that("with character and no overlays", {
    res <- build_bpmnContent(
      paste(
        readLines(
          system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
        ),
        collapse = " "
      ),
      enableDefaultOverlayStyle = TRUE
    )

    expect_true(length(res) == 2)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle"))
  })

  test_that("with character and no overlays", {
    res <- build_bpmnContent(
      system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR"),
      enableDefaultOverlayStyle = TRUE
    )

    expect_true(length(res) == 2)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle"))
  })

  test_that("error", {
    expect_error(build_bpmnContent(iris))
  })
})

test_that("not_null_list works", {
  res <- .not_null_list(x = 1, y = NULL)

  expect_true(length(res) == 1)
  expect_named(res, c("x"))
})