#' create_project
#'
#' This function create an R project
#'
#' @param path A path. If it exists, it is used.
#'   If it does not exist, it is created, provided that the parent path exists.
#' @param git If TRUE, init git.
#'
#' @return Path to the newly created project or package, invisibly.
#'
#' @export
create_project <- function(path, git = TRUE) {
  old_project <- usethis::proj_set(path, force = TRUE)
  on.exit(usethis::proj_set(old_project), add = TRUE)

  dir.create(
    path = usethis::proj_path(),
    recursive = TRUE, showWarnings = FALSE, mode = "0775"
  )

  usethis::use_directory("R")
  usethis::use_directory("docs")
  usethis::use_directory("data")
  usethis::use_directory("outputs")
  usethis::use_directory("reports")
  usethis::use_directory("logs")

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
    ".Rproj.user",
    "**.RData",
    "**.Rdata",
    "**.Ruserdata",
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
    "**.snm",
    "outputs",
    "logs"
  )
  writeLines(gitignore, con = usethis::proj_path(".gitignore"))

  usethis::use_readme_md(open = FALSE)
  if (git) {
    gert::git_init(path = usethis::proj_get())
    gert::git_commit_all(repo = usethis::proj_get(), message = "Init project")
  }

  invisible(usethis::proj_get())
}
