#' Create a resume in HTML
#'
#' This output format is based on Min-Zhong Lu's HTML/CSS in the Github repo
#' [https://github.com/mnjul/html-resume](https://github.com/mnjul/html-resume). See
#' [https://pagedown.rbind.io/html-resume/](https://pagedown.rbind.io/html-resume/) for an example.
#' @param ...,css,template,number_sections See `html_paged`.
#' @return An R Markdown output format.
#' @export
html_resume <- function(
  ...,
  self_contained = TRUE,
  number_sections = FALSE,
  mathjax = "default",
  css = "resume",
  template = "html_resume.html",
  pandoc_args = NULL,
  .pagedjs = TRUE,
  .pandoc_args = NULL,
  .test = FALSE
) {
  .dependencies <- c(
    .dependencies,

  )
  if (!identical(mathjax, "local")) {
    if (identical(mathjax, "default")) {
      mathjax <- rmarkdown:::default_mathjax()
    }
    if (isTRUE(self_contained) && !is.null(mathjax)) {
      pandoc_args <- c(pandoc_args, paste0("--mathjax=", mathjax))
      mathjax <- NULL
    }
  }
  css2 <- grep("[.]css$", css, value = TRUE, invert = TRUE)
  css <- setdiff(css, css2)
  # pagedown:::check_css(css2)

  pandoc_args <- c(
    .pandoc_args,
    pandoc_args,
    if (isTRUE(.pagedjs)) c("--metadata", "newpage_html_class=page-break-after")
  )

  bookdown::html_document2(
    ...,
    theme = NULL,
    number_sections = number_sections,
    self_contained = self_contained,
    mathjax = mathjax,
    css = css,
    template = template,
    pandoc_args = pandoc_args,
    fig_caption = FALSE,
    .pagedjs = .pagedjs,
    extra_dependencies = c(
      extra_dependencies,
      list(
        htmltools::htmlDependency(
          name = "font-awesome",
          version = "5.1.0",
          src = system.file("rmd", "h", "fontawesome", package = "rmarkdown"),
          stylesheet = c("css/all.css", "css/v4-shims.css")
        )
      ),
      list(
        htmltools::htmlDependency(
          name = "paged",
          version = packageVersion("pagedown"),
          src = system.file("resources", package = "pagedown", mustWork = TRUE),
          script = if (.pagedjs) c("js/config.js", if (.test) "js/paged-latest.js" else c("js/paged.js", "js/hooks.js")),
          stylesheet = file.path("css", xfun::with_ext(css2, ".css")),
          all_files = .test
        )
      )
    )
  )
}
