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

  devtools.install.args = c("--no-multiarch", "--no-test-load"),
  styler.cache_root = "styler-perm",
  testthat.default_check_reporter = "progress",
  languageserver.formatting_style = \(.options) {
    style = styler::tidyverse_style(indent_by = .options$tabSize)
    style$token$force_assignment_op = NULL
    style
  }
)

.First = function() {
  suppressWarnings(readRenviron("~/.site.Renviron"))
  Sys.setenv(MAKEFLAGS = paste0("-j", min(getOption("mc.cores"), 4L)))
  if (interactive() && Sys.getenv("RSTUDIO") == "") {
    stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
    cran = c("conflicted", "devtools")
    options(defaultPackages = c(getOption("defaultPackages"), cran, "wtl"))
    setHook(packageEvent("grDevices", "onLoad"), \(...) {
      if (capabilities("aqua")) {
        grDevices::quartz.options(width = 6, height = 6)
        grDevices::quartzFonts(
          mincho = grDevices::quartzFont(paste0("Hiragino Mincho ProN W", c(3, 6, 3, 6))),
          gothic = grDevices::quartzFont(paste0("Hiragino Sans W", c(3, 6, 3, 6)))
        )
      }
    })
    setHook(packageEvent("pkgbuild", "onLoad"), \(...) {
      compiler_flags = \(debug) { # r-lib/pkgload#224
        x = "-Wall -pedantic -fdiagnostics-color=always"
        if (debug) x = paste("-UNDEBUG -g", x)
        c(CFLAGS = x, CXXFLAGS = x, CXX17FLAGS = x, CXX20FLAGS = x)
      }
      assignInNamespace("compiler_flags", compiler_flags, "pkgbuild")
    })
    setHook(packageEvent("conflicted", "attach"), \(...) library(tidyverse))
    setHook(packageEvent("wtl", "attach"), \(...) {
      ggplot2::theme_set(wtl::theme_wtl())
      options(wtl::generate_print_options())
      registerS3method("print", "tbl_df", wtl::printdf)
      registerS3method("print", "tbl", wtl::printdf)
      print(utils::sessionInfo(), locale = FALSE)
    })
    if (Sys.getenv("TERM_PROGRAM") == "vscode") {
      source("~/.vscode-R/init.R")
    }
  }
}

.Last = function() {
  if (interactive()) {
    if (!nzchar(Sys.getenv("RADIAN_VERSION"))) {
      try(utils::savehistory(Sys.getenv("R_HISTFILE")))
    }
    print(ls(envir = .GlobalEnv, all.names = TRUE))
    print(utils::sessionInfo(), locale = FALSE)
  }
}
