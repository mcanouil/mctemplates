#' create_ioslides
#'
#' This function create an R project with ioslides
#'
#' @param path A path. If it exists, it is used.
#'   If it does not exist, it is created, provided that the parent path exists.
#' @param git If TRUE, init git.
#'
#' @return Path to the newly created project or package, invisibly.
#'
#' @export
create_ioslides <- function(path, git = TRUE) {
  old_project <- usethis::proj_set(path, force = TRUE)
  on.exit(usethis::proj_set(old_project), add = TRUE)

  rproj <- c(
    "Version: 1.0",
    "",
    "RestoreWorkspace: No",
    "SaveWorkspace: No",
    "AlwaysSaveHistory: No",
    "",
    "EnableCodeIndexing: Yes",
    "UseSpacesForTab: Yes",
    "NumSpacesForTab: 2",
    "Encoding: UTF-8",
    "",
    "RnwWeave: knitr",
    "LaTeX: pdfLaTeX",
    "",
    "AutoAppendNewline: Yes",
    "",
    "QuitChildProcessesOnExit: Yes"
  )
  writeLines(rproj, con = usethis::proj_path(paste0(basename(path), ".Rproj")))

  gitignore <- c(
    ".Rhistory",
    ".RData",
    ".Rdata",
    ".Rproj.user",
    ".Ruserdata",
    "**.rdb",
    "**.rdx",
    "**.glo",
    "**.ist",
    "**.out",
    "**.nav",
    "**.log",
    "**.bbl",
    "**.blg",
    "**.aux",
    "**.toc",
    "**.snm"
  )
  writeLines(gitignore, con = usethis::proj_path(".gitignore"))

  rbuildignore <- c(
    "^.*\\.Rproj$",
    "^\\.Rproj\\.user$",
    "^\\.travis\\.yml$"
  )
  writeLines(rbuildignore, con = usethis::proj_path(".Rbuildignore"))

  readme <- c(
    paste("#", basename(path)),
    "\n",
    "<!-- badges: start -->",
    "<!-- badges: end -->",
    "\n",
    paste0("This is the work-in-progress repo for the slides about ", basename(path), ".")
  )
  writeLines(readme, con = usethis::proj_path("README.md"))

  description <- c(
    paste("Package: ", basename(path)),
    paste("Title:", basename(path)),
    "Version: 0.0.1",
    "Imports:",
    "    tidyverse,",
    "    rmarkdown,",
    "    knitr,",
    "    kableExtra"
  )
  writeLines(readme, con = usethis::proj_path("DESCRIPTION"))

  file.copy(
    from = system.file(
      "rmarkdown", "templates", "ioslides", "skeleton", "skeleton.Rmd",
      package = "mctemplates"
    ),
    to = "index.Rmd"
  )

  usethis::use_readme_md(open = FALSE)
  if (git) {
    git2r::init(usethis::proj_get())
    git2r::add(usethis::proj_get(), "*")
    git2r::commit(repo = usethis::proj_get(), message = "Init project", all = TRUE)
  }

  invisible(usethis::proj_get())
}
