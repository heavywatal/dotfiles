options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  BioC_mirror = "https://bioconductor.org/",
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

  ggplot2.continuous.colour = "viridis",
  ggplot2.continuous.fill = "viridis",

  testthat.default_check_reporter = "progress",
  menu.graphics = FALSE
)

.First = function() {
  if (interactive()) {
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
        serif = grDevices::pdfFonts()$Palatino,
        mincho = grDevices::pdfFonts()$Japan1,
        gothic = grDevices::pdfFonts()$Japan1GothicBBB
      )
      if (capabilities("aqua")) {
        grDevices::quartz.options(width = 6.5, height = 6.5)
        styles = c("", " Bold", " Italic", " Bold Italic")
        grDevices::quartzFonts(
          serif = grDevices::quartzFont(paste0("Palatino", styles)),
          sans = grDevices::quartzFont(paste0("Helvetica Neue", styles)),
          mono = grDevices::quartzFont(paste0("Menlo", styles)),
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

setHook(packageEvent("languageserver", "onLoad"), function(...) {
  options(languageserver.default_linters = lintr::with_defaults(
    absolute_path_linter = NULL,
    assignment_linter = NULL,
    closed_curly_linter = NULL,
    commented_code_linter = NULL,
    object_length_linter = NULL,
    object_name_linter = NULL,
    object_usage_linter = NULL,
    open_curly_linter = NULL,
    pipe_continuation_linter = NULL,
    spaces_left_parentheses_linter = NULL,
    line_length_linter = lintr::line_length_linter(120)
  ))
})
