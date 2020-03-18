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
#' @param GITHUB_PAT Environment variable for GitHub access token.
#' @param GITLAB_PAT Environment variable for GitLab access token.
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
  TZ = NULL,
  GITHUB_PAT = NULL,
  GITLAB_PAT = NULL
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
    right = crayon::blue("MC")
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
    if (!is.null(GITHUB_PAT)) glue::glue("GITHUB_PAT={GITHUB_PAT}"),
    if (!is.null(GITLAB_PAT)) glue::glue("GITLAB_PAT={GITLAB_PAT}"),
    if (!is.null(TZ)) glue::glue("TZ='{TZ}'"),
    if (!is.null(R_LIBS_USER)) glue::glue("R_LIBS_USER={R_LIBS_USER}")
  )
  cat(env_var, sep = "\n", file = .Renviron)
  readRenviron(path = .Renviron)
  for (ienv in readLines(.Renviron)) {
    if (grepl("^GIT", ienv)) ienv <- gsub("(.*=).*", "\\1=XXXXXXXX", ienv)
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

  if (nchar(system.file(package = "prompt")) == 0) {
    prompt::set_prompt(prompt::prompt_git)
    cli::cat_line(
      glue::glue(.sep = " ",
        '{crayon::green(clisymbols::symbol$tick)}',
        '{crayon::green("prompt")} set to {crayon::blue("prompt::prompt_git")}'
      )
    )
  }

  options(usethis.protocol = "https")
  set_option("usethis.protocol")

  if (is.null(given) | is.null(family)) {
    options(usethis.full_name = paste(given, family))
    set_option("usethis.full_name")
  }

  if (is.null(given) | is.null(family)) {
    options(usethis.description = list(
      `Authors@R` = glue::glue('person(given = "{given}",
        family = "{family}",
        role = c("aut", "cre"),
        email = "{email}",
        comment = c(ORCID = "{orcid}"))'),
      Version = "0.0.0.9000"
    ))
  } else {
    options(usethis.description = list(Version = "0.0.0.9000"))
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
    X = c("devtools", "usethis", "testthat", "reprex", "git2r"),
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

  cli::cat_line(crayon::white(cli::rule()))
  invisible()
}
