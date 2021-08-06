options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  menu.graphics = FALSE,

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
  readr.show_types = FALSE,
  dplyr.summarise.inform = FALSE,

  ggplot2.continuous.colour = "viridis",
  ggplot2.continuous.fill = "viridis",

  devtools.install.args = c("--no-multiarch", "--no-test-load"),
  testthat.default_check_reporter = "progress"
)

.First = function() {
  try(suppressWarnings(readRenviron("~/.Renviron.site")))
  if (interactive() && Sys.getenv("RSTUDIO") == "") {
    stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
    cran = c("tidyverse", "devtools")
    github = c("wtl")
    options(defaultPackages = c(getOption("defaultPackages"), cran, github))
    if (!(.Platform$GUI %in% c("AQUA", "Rgui")) && Sys.getenv("INSIDE_EMACS") == "") {
      utils::loadhistory(file = Sys.getenv("R_HISTFILE"))
    }
    print(utils::sessionInfo(), locale = FALSE)
    cat("Loading:", cran, github, "\n")
    setHook(packageEvent("grDevices", "onLoad"), function(...) {
      grDevices::pdfFonts(
        mincho = grDevices::pdfFonts()$Japan1,
        gothic = grDevices::pdfFonts()$Japan1GothicBBB
      )
      if (capabilities("aqua")) {
        grDevices::quartz.options(width = 6, height = 6)
        grDevices::quartzFonts(
          mincho = grDevices::quartzFont(paste0("Hiragino Mincho ProN W", c(3, 6, 3, 6))),
          gothic = grDevices::quartzFont(paste0("Hiragino Kaku Gothic ProN W", c(3, 6, 3, 6)))
        )
      }
    })
    setHook(packageEvent("tibble", "attach"), function(...) {
      registerS3method("print", "tbl_df", wtl::printdf)
      registerS3method("print", "tbl", wtl::printdf)
    })
    setHook(packageEvent("wtl", "attach"), function(...) {
      ggplot2::theme_set(wtl::theme_wtl())
      wtl::adjust_print_options()
      mc.cores = parallel::detectCores(logical = FALSE)
      options(mc.cores = mc.cores)
      Sys.setenv(MAKEFLAGS = paste0("-j", min(mc.cores, 4L)))
    })
  }
}

.Last = function() {
  try({
    if (interactive()) {
      if (!(.Platform$GUI %in% c("AQUA", "Rgui")) && Sys.getenv("INSIDE_EMACS") == "") {
        utils::savehistory(file = Sys.getenv("R_HISTFILE"))
      }
      print(ls(envir = .GlobalEnv, all.names = TRUE))
      print(utils::sessionInfo(), locale = FALSE)
    }
  })
}
