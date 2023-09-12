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

describe("create_edge_style works", {
  test_that("with invalid elementIds argument", {
    expect_error(create_edge_style(elementIds = "invalid_element_id", stroke_color = "blue"), regexp = "elementIds must be a list!!", fixed = TRUE)
  })
  
  test_that("with no optional arguments", {
    expect_error(create_edge_style(elementIds = list("edge-1")), regexp = "At least one style property (e.g., stroke_color, font_color, opacity, ...) must be provided!!", fixed = TRUE)
  })
  
  test_that("with opacity, font, stroke", {
    res <- create_edge_style(
      elementIds = list("edge-1"),
      stroke_color = "red",
      stroke_width = 2,
      stroke_opacity = 80,
      font_color = "blue",
      font_family = "Arial",
      font_size = 14,
      font_bold = TRUE,
      font_italic = FALSE,
      font_strike_through = TRUE,
      font_underline = FALSE,
      font_opacity = 60,
      opacity = 70
    )
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    
    style <- res$style
    expect_type(style, "list")
    expect_length(style, 3)
    expect_named(style, c("stroke", "font", "opacity"))
    
    expect_equal(style$opacity, 70)
    expect_equal(style$stroke, list(
      color = "red",
      width = 2,
      opacity = 80
    ))
    expect_equal(
      style$font,
      list(
        color = "blue",
        size = 14,
        family = "Arial",
        opacity = 60,
        isBold = TRUE,
        isItalic = FALSE,
        isStrikeThrough = TRUE,
        isUnderline = FALSE
      )
    )
  })
  
  test_that("with only opacity", {
    res <- create_edge_style(elementIds = list("edge-1"), opacity = 60)
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    
    style <- res$style
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("opacity"))
    expect_equal(style$opacity, 60)
  })
  
  test_that("with only font", {
    res <-
      create_edge_style(
        elementIds = list("edge-1"),
        font_color = "blue",
        font_family = "Open Sans",
        font_size = 14,
        font_opacity = 80,
        font_bold = TRUE,
        font_italic = FALSE,
        font_strike_through = FALSE,
        font_underline = TRUE
      )
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    
    style <- res$style
    expect_type(style, "list")
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("font"))
    expect_equal(
      style$font,
      list(
        color = "blue",
        size = 14,
        family = "Open Sans",
        opacity = 80,
        isBold = TRUE,
        isItalic = FALSE,
        isStrikeThrough = FALSE,
        isUnderline = TRUE
      )
    )
  })
  
  test_that("with only stroke", {
    res <-
      create_edge_style(
        elementIds = list("edge-1"),
        stroke_color = "red",
        stroke_width = 2,
        stroke_opacity = 45
      )
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    
    style <- res$style
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("stroke"))
    expect_equal(style$stroke, list(
      color = "red",
      width = 2,
      opacity = 45
    ))
  })
  
  test_that("with font color with 'inherit'", {
    res <- create_edge_style(elementIds = list("edge-1"), font_color = "inherit")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    expect_equal(res$style$font$color, "inherit")
  })
  
  test_that("with stroke color with 'default'", {
    res <- create_edge_style(elementIds = list("edge-1"), stroke_color = "default")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    expect_equal(res$style$stroke$color, "default")
  })
  
  test_that("with stroke width with 'default'", {
    res <- create_edge_style(elementIds = list("edge-1"), stroke_width = "default")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("edge-1"))
    expect_equal(res$style$stroke$width, "default")
  })
})

describe("create_shape_style works", {
  test_that("with invalid elementIds argument", {
    expect_error(create_shape_style(elementIds = "invalid_element_id", stroke_color = "blue"), regexp = "elementIds must be a list!!", fixed = TRUE)
  })
  
  test_that("with no optional arguments", {
    expect_error(create_shape_style(elementIds = list("shape-1")), regexp = "At least one style property (e.g., stroke_color, font_color, fill_opacity, opacity, ...) must be provided!!", fixed = TRUE)
  })
  
  test_that("with opacity, font, stroke, fill", {
    res <- create_shape_style(
      elementIds = list("shape-1"),
      stroke_color = "red",
      stroke_width = 2,
      stroke_opacity = 80,
      font_color = "blue",
      font_family = "Arial",
      font_size = 14,
      font_bold = TRUE,
      font_italic = FALSE,
      font_strike_through = TRUE,
      font_underline = FALSE,
      font_opacity = 60,
      opacity = 70,
      fill_color = "green",
      fill_opacity = 40
    )
   
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 4)
    expect_named(style, c("stroke", "font", "opacity", "fill"))
    
    expect_equal(style$opacity, 70)
    expect_equal(style$stroke, list(
      color = "red",
      width = 2,
      opacity = 80
    ))
    expect_equal(
      style$font,
      list(
        color = "blue",
        size = 14,
        family = "Arial",
        opacity = 60,
        isBold = TRUE,
        isItalic = FALSE,
        isStrikeThrough = TRUE,
        isUnderline = FALSE
      )
    )
    expect_equal(style$fill, list(color = "green", opacity = 40))
  })
  
  test_that("with only opacity", {
    res <- create_shape_style(elementIds = list("shape-1"), opacity = 60)
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("opacity"))
    expect_equal(style$opacity, 60)
  })
  
  test_that("with only font", {
    res <-
      create_shape_style(
        elementIds = list("shape-1"),
        font_color = "blue",
        font_family = "Open Sans",
        font_size = 14,
        font_opacity = 80,
        font_bold = TRUE,
        font_italic = FALSE,
        font_strike_through = FALSE,
        font_underline = TRUE
      )
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("font"))
    expect_equal(
      style$font,
      list(
        color = "blue",
        size = 14,
        family = "Open Sans",
        opacity = 80,
        isBold = TRUE,
        isItalic = FALSE,
        isStrikeThrough = FALSE,
        isUnderline = TRUE
      )
    )
  })
  
  test_that("with only stroke", {
    res <-
      create_shape_style(
        elementIds = list("shape-1"),
        stroke_color = "red",
        stroke_width = 2,
        stroke_opacity = 45
      )
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("stroke"))
    expect_equal(style$stroke, list(
      color = "red",
      width = 2,
      opacity = 45
    ))
  })
  
  test_that("with only fill", {
    res <- create_shape_style(elementIds = list("shape-1"), fill_color = "green", fill_opacity = 50)
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("fill"))
    expect_equal(style$fill, list(color = "green", opacity = 50))
  })
  
  test_that("with fill color with gradient", {
    gradient <- create_gradient_fill("left-to-right", "red", "blue")
    
    res <- create_shape_style(elementIds = list("shape-1"), fill_color = gradient)
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    
    style <- res$style 
    expect_type(style, "list")
    expect_length(style, 1)
    expect_named(style, c("fill"))
    expect_equal(
      style$fill$color,
      list(
        direction = "left-to-right",
        startColor = "red",
        endColor = "blue"
      )
    )
  })
  
  test_that("with fill color with 'swimlane'", {
    res <- create_shape_style(elementIds = list("shape-1"), fill_color = "swimlane")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    expect_equal(res$style$fill$color, "swimlane")
  })
  
  test_that("with font color with 'inherit'", {
    res <- create_shape_style(elementIds = list("shape-1"), font_color = "inherit")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    expect_equal(res$style$font$color, "inherit")
  })
  
  test_that("with stroke color with 'default'", {
    res <- create_shape_style(elementIds = list("shape-1"), stroke_color = "default")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    expect_equal(res$style$stroke$color, "default")
  })
  
  test_that("with stroke width with 'default'", {
    res <- create_shape_style(elementIds = list("shape-1"), stroke_width = "default")
    
    expect_type(res, "list")
    expect_length(res, 2)
    expect_named(res, c("elementIds", "style"))
    
    expect_equal(res$elementIds, list("shape-1"))
    expect_equal(res$style$stroke$width, "default")
  })
})

describe("build_bpmnContent works", {
  test_that("with xml_doc, no overlays and no bpmnElementStyles", {
    res <- build_bpmnContent(
      bpmnXML = xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = TRUE
    )

    expect_true(length(res) == 2)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle"))
  })

  test_that("with xml_doc, overlays and no bpmnElementStyles", {
    res <- build_bpmnContent(
      bpmnXML = xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = FALSE,
      overlays = "this"
    )

    expect_true(length(res) == 3)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle", "overlays"))

    expect_equal(res$overlays, list("this"))
  })

  test_that("with xml_doc, overlays is list and no bpmnElementStyles", {
    res <- build_bpmnContent(
      bpmnXML = xml2::read_xml(
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

  test_that("with xml_doc, no overlays and bpmnElementStyles is list", {
    res <- build_bpmnContent(
      bpmnXML = xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      enableDefaultOverlayStyle = TRUE,
      bpmnElementStyles = list(list(elementIds=list(1, 2), style = "style"))
    )

    expect_true(length(res) == 3)
    expect_named(res, c("bpmnContent", "enableDefaultOverlayStyle", "bpmnElementStyles"))

    expect_equal(res$bpmnElementStyles, list(list(elementIds=list(1, 2), style = "style")))
  })
  
  test_that("with xml_doc, no overlays and bpmnElementStyles is bad list", {
    expect_error(build_bpmnContent(
      bpmnXML = xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      bpmnElementStyles = list("this")
    ))
  })

  test_that("with xml_doc, no overlays and bpmnElementStyles is not list", {
    expect_error(build_bpmnContent(
      bpmnXML = xml2::read_xml(
        system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR")
      ),
      bpmnElementStyles = "this"
    ))
  })

  test_that("with character, no overlays and no bpmnElementStyles", {
    res <- build_bpmnContent(
      bpmnXML = paste(
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

  test_that("with character, no overlays and no bpmnElementStyles", {
    res <- build_bpmnContent(
      bpmnXML = system.file("examples/Email_Voting.bpmn", package = "bpmnVisualizationR"),
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