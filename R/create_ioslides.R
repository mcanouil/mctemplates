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

  dir.create(
    path = usethis::proj_path(),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )

  usethis::use_directory("docs")

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
    "LineEndingConversion: Posix",
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
    "^\\.Rproj\\.user$"
  )
  writeLines(rbuildignore, con = usethis::proj_path(".Rbuildignore"))

  description <- c(
    paste("Package: ", basename(path)),
    paste("Title:", basename(path)),
    "Version: 0.1.0",
    "Imports:",
    "    mctemplates,",
    "    here",
    "    knitr",
    "    rmarkdown,",
    "    ragg",
    "    ggplot2",
    "    ggtext",
    "    patchwork",
    "    data.table",
    "    gt,",
    "Remotes:",
    "    github::mcanouil/mctemplates"
  )
  writeLines(description, con = usethis::proj_path("DESCRIPTION"))

  file.copy(
    from = system.file(
      "rmarkdown", "templates", "ioslides", "skeleton", "skeleton.Rmd",
      package = "mctemplates"
    ),
    to = usethis::proj_path("index.Rmd")
  )

  readme <- c(
    paste("#", basename(path)),
    "\n<!-- badges: start -->", "<!-- badges: end -->\n",
    paste0("This is the work-in-progress repo for the slides about ", basename(path), ".")
  )
  writeLines(readme, con = usethis::proj_path("README.md"))

  if (git) {
    gert::git_init(path = usethis::proj_get())
    gert::git_add(files = "*")
    gert::git_commit_all(repo = usethis::proj_get(), message = "Init project")
  }

  invisible(usethis::proj_get())
}
