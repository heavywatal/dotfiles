# Disable annoying X11 popup
options(menu.graphics = FALSE)

# Choose server
options(download.file.method = "libcurl")
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Show more warnings
options(
  warn = 1,
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE
)

# Show a summary of the call stack
options(
  showWarnCalls = TRUE,
  showErrorCalls = TRUE
)

options(
  datatable.print.class = TRUE,
  datatable.print.colnames = "top",
  pillar.subtle = FALSE,
  pillar.neg = FALSE,
  readr.num_columns = 0L
)

options(
  mc.cores = parallel::detectCores(logical = FALSE)
)

.First = function() {
  if (interactive()) {
    cran = c("tidyverse", "fs", "devtools")
    github = c("wtl")
    options(defaultPackages = c(getOption("defaultPackages"), cran, github))
    if (!(.Platform$GUI %in% c("AQUA", "Rgui")) && Sys.getenv("EMACS") == "") {
      utils::loadhistory(file = Sys.getenv("R_HISTFILE"))
    }
    print(utils::sessionInfo(), locale = FALSE)
    cat(date(), "\n")
    cat(getwd(), "\n")
    cat("Loading:", cran, github, "\n")
    wtl::adjust_print_options()
    assign("print.tbl_df", data.table:::print.data.table, envir = .GlobalEnv)
    assign("print.tbl", data.table:::print.data.table, envir = .GlobalEnv)
  }
}

.Last = function() {
  try({
    if (interactive()) {
      if (!(.Platform$GUI %in% c("AQUA", "Rgui")) && Sys.getenv("EMACS") == "") {
        utils::savehistory(file = Sys.getenv("R_HISTFILE"))
      }
      print(ls(envir = globalenv(), all.names = TRUE))
      print(utils::sessionInfo(), locale = FALSE)
    }
  })
}
