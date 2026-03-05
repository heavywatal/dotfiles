options(
  repos = getOption("repos", c(CRAN = "https://cloud.r-project.org")),
  menu.graphics = FALSE,
  mc.cores = parallel::detectCores(logical = FALSE),

  warn = 1,
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE,
  showWarnCalls = TRUE,
  showErrorCalls = TRUE,

  datatable.print.class = TRUE,
  datatable.print.colnames = "top",
  pillar.subtle = FALSE,
  pillar.neg = FALSE,
  readr.num_columns = 0L,
  readr.show_progress = FALSE,
  readr.show_col_types = FALSE,
  dplyr.summarise.inform = FALSE,

  gargle_oauth_email = TRUE,
  gargle_oauth_cache = TRUE,

  devtools.install.args = c("--no-multiarch", "--no-test-load")
)

.First = function() {
  suppressWarnings(readRenviron("~/.site.Renviron"))
  Sys.setenv(MAKEFLAGS = paste0("-j", min(getOption("mc.cores"), 4L)))
  if (interactive() && Sys.getenv("RSTUDIO") == "") {
    stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
    pkgs = c("conflicted", "tidyverse", "devtools")
    options(defaultPackages = c(getOption("defaultPackages"), pkgs, "wtl"))
    setHook(packageEvent("wtl", "attach"), \(...) {
      ggplot2::theme_set(wtl::theme_wtl())
      options(wtl::generate_print_options())
      registerS3method("print", "tbl_df", wtl::printdf)
      registerS3method("print", "tbl", wtl::printdf)
      assign("load_all", wtl::lall, envir = attach(NULL, name = "alias"))
    })
    if (Sys.getenv("TERM_PROGRAM") == "vscode") {
      source("~/.vscode-R/init.R")
    }
  }
}

.Last = function() {
  if (interactive()) {
    try(utils::savehistory(Sys.getenv("R_HISTFILE", "~/.Rhistory")))
  }
}
