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

  devtools.install.args = c("--no-multiarch", "--no-test-load"),
  styler.cache_root = "styler-perm",
  testthat.default_check_reporter = "progress"
)

options(languageserver.formatting_style = function(options) {
  style = styler::tidyverse_style(indent_by = options$tabSize)
  style$token$force_assignment_op = NULL
  style
})

.First = function() {
  try(suppressWarnings(readRenviron("~/.Renviron.site")))
  if (interactive() && Sys.getenv("RSTUDIO") == "") {
    stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
    cran = c("tidyverse", "devtools")
    github = "wtl"
    options(
      defaultPackages = c(getOption("defaultPackages"), cran, github),
      ggplot2.continuous.colour = "viridis",
      ggplot2.continuous.fill = "viridis"
    )
    Sys.setenv(MAKEFLAGS = paste0("-j", min(getOption("mc.cores"), 4L)))
    print(utils::sessionInfo(), locale = FALSE)
    setHook(packageEvent("grDevices", "onLoad"), function(...) {
      grDevices::pdfFonts(
        mincho = grDevices::pdfFonts()$Japan1,
        gothic = grDevices::pdfFonts()$Japan1GothicBBB
      )
      if (capabilities("aqua")) {
        grDevices::quartz.options(width = 6, height = 6)
        grDevices::quartzFonts(
          mincho = grDevices::quartzFont(paste0("Hiragino Mincho ProN W", c(3, 6, 3, 6))),
          gothic = grDevices::quartzFont(paste0("Hiragino Sans W", c(3, 6, 3, 6)))
        )
      }
    })
    setHook(packageEvent("tibble", "attach"), function(...) {
      registerS3method("print", "tbl_df", wtl::printdf)
      registerS3method("print", "tbl", wtl::printdf)
    })
    setHook(packageEvent("wtl", "attach"), function(...) {
      ggplot2::theme_set(wtl::theme_wtl())
      options(wtl::generate_print_options())
    })
    if (dir.exists(Sys.getenv("VSCODE_WATCHER_DIR"))) {
      Sys.setenv(TERM_PROGRAM = "vscode")  # for non-native "R terminal"
      options(vsc.plot = FALSE)  # disable png viewer
      options(vsc.view = "Active")
      options(vsc.helpPanel = "Active")
      source(file.path(Sys.getenv("VSCODE_WATCHER_DIR"), "init.R"))
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
