#' .Rprofile configuration as a function
#'
#' @param given A character string with the given names.
#' @param family A character string with the family name.
#' @param email A character string giving an e-mail address.
#' @param orcid A chracter string giving an ORCID.
#' @param .Renviron Path to the `.Renviron` file.
#' @param LANGUAGE Environment variable for language.
#' @param R_LIBS_USER Environment variable for user library.
#' @param R_MAX_NUM_DLLS Environment variable for the maximum number of DLLs to be loaded.
#' @param TZ Environment variable for time zone.
#'
#' @return NULL
#' @export
mcprofile <- function(
  given = NULL,
  family = NULL,
  email = NULL,
  orcid = NULL,
  .Renviron = "~/.Renviron",
  LANGUAGE = NULL,
  R_LIBS_USER = NULL,
  R_MAX_NUM_DLLS = NULL,
  TZ = NULL
) {
  set_option <- function(x) {
    cli::cat_line(
      glue::glue(.sep = " ",
        "{crayon::green(clisymbols::symbol$tick)}",
        "{crayon::green(x)} set to {crayon::blue(options(x))}"
      )
    )
  }

  cli::cat_line(crayon::white(cli::rule(
    left = paste(crayon::bold("Load"), crayon::blue(".Rprofile")),
    right = crayon::blue(paste0("Version ", utils::packageVersion("mctemplates"))),
    width = 80
  )))

  if (.Platform$OS.type == "unix" & !is.null(LANGUAGE)) {
    cli::cat_line(
      glue::glue(
        '{crayon::red(clisymbols::symbol$bullet)} Set {crayon::blue("locales")}'
      )
    )
    invisible(lapply(
      X = c(
        "LC_ALL", "LC_CTYPE", "LC_TIME", "LC_COLLATE", "LC_MONETARY",
        "LC_MESSAGES", "LC_PAPER", "LC_MEASUREMENT"
      ),
      FUN = Sys.setlocale, locale = LANGUAGE
    ))
    cli::cat_line(
      glue::glue(.sep = " ",
        "{crayon::green(clisymbols::symbol$tick)}",
        "{crayon::green('locales')} set to {crayon::blue(LANGUAGE)}"
      )
    )
  }

  cli::cat_line(
    glue::glue(
      '{crayon::red(clisymbols::symbol$bullet)} Write & load {crayon::blue(".Renviron")}'
    )
  )
  env_var <- c(
    if (!is.null(LANGUAGE)) glue::glue("LANGUAGE='{LANGUAGE}'"),
    if (!is.null(R_MAX_NUM_DLLS)) glue::glue("R_MAX_NUM_DLLS={R_MAX_NUM_DLLS}"),
    if (!is.null(TZ)) glue::glue("TZ='{TZ}'"),
    if (!is.null(R_LIBS_USER)) glue::glue("R_LIBS_USER={R_LIBS_USER}")
  )
  cat(env_var, sep = "\n", file = .Renviron)
  readRenviron(path = .Renviron)
  for (ienv in readLines(.Renviron)) {
    cli::cat_line(
      glue::glue(.sep = " ",
        "{crayon::blue(clisymbols::symbol$info)}",
        "{crayon::green(gsub('=.*$', '', ienv))}",
        "set to {crayon::blue(gsub('^.*=', '', ienv))}"
      )
    )
  }

  cli::cat_line(glue::glue('{crayon::red(clisymbols::symbol$bullet)} Set options'))
  options(menu.graphics = FALSE)
  set_option("menu.graphics")

  options(width = 120)
  set_option("width")

  options(reprex.advertise = FALSE)
  set_option("reprex.advertise")

  options(error = rlang::entrace)
  cli::cat_line(
    glue::glue(.sep = " ",
      '{crayon::green(clisymbols::symbol$tick)}',
      '{crayon::green("error")} set to {crayon::blue("rlang::entrace")}'
    )
  )

  options(rlang_backtrace_on_error = "branch")
  set_option("rlang_backtrace_on_error")

  if (nchar(system.file(package = "prompt", lib.loc = c(Sys.getenv("R_LIBS"), Sys.getenv("R_LIBS_USER")))) != 0) {

    set_prompt(prompt_git)
    cli::cat_line(
      glue::glue(.sep = " ",
        '{crayon::green(clisymbols::symbol$tick)}',
        '{crayon::green("prompt")} set to {crayon::blue("prompt_git")}'
      )
    )
  }

  options(usethis.protocol = "https")
  set_option("usethis.protocol")

  if (!is.null(given) & !is.null(family)) {
    options(usethis.full_name = paste(given, family))
    set_option("usethis.full_name")
  }

  if (is.null(given) | is.null(family)) {
    options(usethis.description = list(Version = "0.0.0.9000"))
  } else {
    options(usethis.description = list(
      `Authors@R` = glue::glue('person(given = "{given}", family = "{family}", role = c("aut", "cre"), email = "{email}", comment = c(ORCID = "{orcid}"))'),
      Version = "0.0.0.9000"
    ))
  }
  cli::cat_line(
    glue::glue(
      '{crayon::green(clisymbols::symbol$tick)} {crayon::green("usethis.description")}'
    )
  )
  for (idesc in names(options('usethis.description')[[1]])) {
    temp <- options('usethis.description')[[1]][[idesc]]
    cli::cat_line(
      glue::glue(.sep = " ",
        "  {crayon::blue(clisymbols::symbol$info)} {crayon::green(idesc)}",
        "set to {crayon::blue(if (nchar(temp) > 12) '...' else temp)}"
      )
    )
  }

  cli::cat_line(glue::glue('{crayon::red(clisymbols::symbol$bullet)} Load packages'))
  invisible(lapply(
    X = c("devtools", "usethis", "testthat", "reprex", "gert"),
    FUN = function(x) {
      if (require(x, character.only = TRUE, quietly = TRUE, warn.conflicts = FALSE)) {
        cli::cat_line(
          glue::glue(
            "{crayon::green(clisymbols::symbol$tick)} {crayon::blue(x)}"
          )
        )
      } else {
        cli::cat_line(
          glue::glue(
            "{crayon::red(clisymbols::symbol$cross)} {crayon::blue(x)}"
          )
        )
      }
    }
  ))

  cli::cat_line(crayon::white(cli::rule(width = 80)))
  invisible()
}

#' @rdname rprofile
#' @export
prompt_git <- function(...) {
  not_git <- inherits(try(gert::git_find(), silent = TRUE), "try-error")
  if (not_git) return("> ")

  ahead_behind <- gert::git_ahead_behind()

  paste0(
    gert::git_branch(),
    if (nrow(gert::git_diff()) != 0) "*" else "",
    if (ahead_behind$ahead > 0) clisymbols::symbol$arrow_up,
    if (ahead_behind$behind > 0) clisymbols::symbol$arrow_down,
    " > "
  )
}

#' Dynamic R Prompt
#'
#' Set the R prompt dynamically, from a function.
#'
#' @docType package
#' @name prompt
NULL

prompt_env <- new.env()
prompt_env$prompt <- "> "
prompt_env$task_id <- NA
prompt_env$error <- NULL
prompt_env$default_prompt <- prompt_env$prompt
prompt_env$disabled_prompt <- NULL
prompt_env$in_use <- TRUE

.onLoad <- function(libname, pkgname) {
  assign("task_id", addTaskCallback(update_callback), envir = prompt_env)
  if (interactive()) {
    assign("error", getOption("error"), envir = prompt_env)
    options(error = prompt_error_hook)
  }
}

update_callback <- function(expr, value, ok, visible) {
  try(suppressWarnings(update_prompt(expr, value, ok, visible)))
  TRUE
}

.onUnload <- function(libpath) {
  removeTaskCallback(prompt_env$task_id)
  assign("task_id", NA, envir = prompt_env)
  if (interactive()) options(error = prompt_env$error)
}

update_prompt <- function(...) {
  mine <- prompt_env$prompt
  if (is.function(mine)) mine <- mine(...)
  if (is.string(mine)) options(prompt = mine)
}

#' Set and control the prompt
#'
#' @param value A character string for a static prompt, or
#'   a function that is called after the evaluation every expression
#'   typed at the R prompt. The function should always return a
#'   character scalar.
#'
#' @details
#' Function \code{update_prompt()} is used to replace the default \R
#' prompt with a custom prompt.   A custom prompt can be disabled
#' with \code{suspend()} and then re-enable with \code{restore()}.
#' Function \code{toggle()} toggles between the two.
#'
#' @export
set_prompt <- function(value) {
  stopifnot(is.function(value) || is.string(value))
  assign("prompt", value, envir = prompt_env)
  update_prompt(NULL, NULL, TRUE, FALSE)
}


#' @rdname set_prompt
#' @export
suspend <- function() {
  if (!prompt_env$in_use) return(invisible(FALSE))
  prompt_env$disabled_prompt <- prompt_env$prompt
  set_prompt(prompt_env$default_prompt)
  prompt_env$in_use <- FALSE
  invisible(TRUE)
}

#' @rdname set_prompt
#' @export
restore <- function() {
  if (prompt_env$in_use) return(invisible(FALSE))
  set_prompt(prompt_env$disabled_prompt)
  prompt_env$in_use <- TRUE
  invisible(TRUE)
}

#' @rdname set_prompt
#' @export
toggle <- function() {
  if (prompt_env$in_use) suspend() else restore()
}

#' @rdname set_prompt
#' @export
prompt_error_hook <- function() {
  update_prompt(expr = NA, value = NA, ok = FALSE, visible = NA)

  orig <- prompt_env$error
  if (!is.null(orig) && is.function(orig)) orig()
  if (!is.null(orig) && is.call(orig)) eval(orig)
}

#' @noRd
#' @keywords internal
is.string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}
