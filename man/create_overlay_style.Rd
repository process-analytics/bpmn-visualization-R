% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/funs.R
\name{create_overlay_style}
\alias{create_overlay_style}
\title{Create the style of an overlay}
\usage{
create_overlay_style(
  font_color = NULL,
  font_size = NULL,
  fill_color = NULL,
  stroke_color = NULL
)
}
\arguments{
\item{font_color}{The font color of the overlay. It can be any HTML color name or HEX code.}

\item{font_size}{The font size of the overlay. Specify a number in pixels.}

\item{fill_color}{The color of the background of the overlay. It can be any HTML color name or HEX code.}

\item{stroke_color}{The color of the stroke of the overlay. It can be any HTML color name or HEX code.\cr
If you don't want to display a stroke, you can set the color to:
\itemize{
\item \code{transparent},
\item the same value as for the \code{fill_color}. This increases the \code{padding}/\code{margin}.
}}
}
\value{
The style object of the overlay
}
\description{
When adding an overlay to an existing element in a diagram, it's possible to customize its style.

Refer to the \code{style} parameter in the \code{\link{create_overlay}} function for more information.

Use this function to create the correct style structure for an overlay.
}
