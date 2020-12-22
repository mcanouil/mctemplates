#' check_commit
#'
#' @param root_directory A directory.
#' @param group A UNIX group.
#' @param commit A boolean.
#' @param push A boolean.
#'
#' @return A tibble
#' @export
check_commit <- function(
  root_directory = "/disks/PROJECT",
  group = "staff",
  commit = FALSE,
  push = FALSE
) {
  dta <- fs::dir_info(path = root_directory, recurse = FALSE)
  dta <- dta[fs::is_dir(dta[["path"]]), c("path", "user", "group", "access_time")]
  dta <- dta[dta[["group"]] == group & dta[["user"]] != "root", ]
  dta <- dta[sapply(dta[["path"]], function(x) !inherits(try(gert::git_find(path = x), silent = TRUE), "try-error")), ]
  dta <- dta[!grepl("^SB_", basename(dta[["path"]])), ]
  dta[["commit"]] <- sapply(dta[["path"]], function(x) nrow(gert::git_diff(repo = x)) > 0)

  if (commit) {
    sapply(
      X = dta[dta[["commit"]], ][["path"]],
      FUN = function(x) gert::git_commit_all(message = "automatic commit", repo = x)
    )
  }

  if (push) {
    sapply(
      X = dta[["path"]],
      FUN = function(x) try(gert::git_push(repo = x))
    )
  }

  dta[dta[["commit"]], c("path", "user", "group", "access_time")]
}
