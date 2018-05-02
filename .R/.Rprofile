options(
  menu.graphics = FALSE,
  repos = c(CRAN = "https://cloud.r-project.org/"),
  BioC_mirror = "https://bioconductor.org/",

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

  mc.cores = parallel::detectCores(logical = FALSE)
)

.First = function() {
  stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
  if (interactive()) {
    cran = c("tidyverse", "fs", "devtools")
    github = c("wtl")
    options(defaultPackages = c(getOption("defaultPackages"), cran, github))
    if (!(.Platform$GUI %in% c("AQUA", "Rgui")) && Sys.getenv("INSIDE_EMACS") == "") {
      utils::loadhistory(file = Sys.getenv("R_HISTFILE"))
    }
    print(utils::sessionInfo(), locale = FALSE)
    cat(date(), "\n")
    cat(getwd(), "\n")
    cat("Loading:", cran, github, "\n")
    setHook(packageEvent("tibble", "attach"), function(...) {
      try({
        assign("print.tbl_df", data.table:::print.data.table, envir = .GlobalEnv)
        assign("print.tbl", data.table:::print.data.table, envir = .GlobalEnv)
      })
    })
    setHook(packageEvent("wtl", "attach"), function(...) {
      wtl::adjust_print_options()
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
