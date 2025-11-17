# ------------------------------------------------------------------------------
# Development Script for R Packages
# Author: Ricardo Semião (github.com/ricardo-semiao)
# Last updated: 19/10/2025
# Repository: ricardo-semiao/ricardo-semiao:packages/dev_rpkg.R
#
# This script provides an organization of the several utility functions for
# developing R packages provided by devtools and friends.
#
# It conditions the usage of best practices as recommended by the devtools
# family of packages and the books "R Packages (2e)" by Hadley Wickham and
# "rOpenSci Packages: Development, Maintenance, and Peer Review" by the rOpenSci
# software review editorial team.
#
# I use a "personal/" folder to store personal builds, reports, and other files.
#
# The script is organized from end to beggining:
# - Section A: set the package up (basically run once per package).
# - Section B: update DESCRIPTION, dependencies, version, and releases.
# - Section C: rebuilding and testing the package.
# - Section D: creating new files and a blank canvas for informal debugging.
# - Appendix 1: other tips for package development, including packages you
# should use.
# - Appendix 2: utility functions used in this script.
# ------------------------------------------------------------------------------



# D. New Files and Debugging ---------------------------------------------------

# D1. Creating:
if (FALSE) {
  usethis::use_r("name")
  usethis::use_test("empty_test") # Or `use_test_helper()`
  usethis::use_vignette("example") # Or `use_article("name")`
  usethis::rename_files()
  # Others: `use_tutorial()`, `use_data_raw()`, `use_data()`
}


# D2. Informal debugging:
devtools::load_all() # Or maybe `reload()`
devtools::document()
#mathjaxr::preview_rd("path", type = "html", verbose = TRUE) # For mathjax docs



# C. Rebuilding and Testing ----------------------------------------------------

# C1. Load and document:
devtools::load_all() # Or maybe `reload()`
devtools::document()
devtools::build_readme()
devtools::build_vignettes() # Uninstall with `clean_vignettes()`


# C2. Essencial tests:
devtools::check_man()
devtools::test()
devtools::run_examples()
devtools::check(check_dir = "personal/")
revdepcheck::revdep_check()


# C3. Installing and building site/manual:
devtools::install(upgrade = FALSE) # Unistall with `uninstall()`
devtools::build_manual(path = "personal/")

pkgdown::clean_site(force = TRUE)
pkgdown::build_site(preview = FALSE)

devtools::build(path = "personal/")
devtools::build(path = "personal/", binary = TRUE)


# C4. Additional checks:
if (FALSE) {
  # Coverage, spelling, and linting:
  report_coverage <- covr::package_coverage(".")
  covr::report(coverage_report)

  report_spell <- spelling::spell_check_package(".")
  print(report_spell)
  spelling::update_wordlist()

  report_lint <- lintr::lint_package(".")
  print(report_lint)

  summarize_reports(report_lint, report_spell, report_lint)

  # Override style - warning commit before using!
  retport_style <- styler::style_pkg(
    scope = "line_breaks",
    style = styler::tidyverse_style,
    strict = TRUE
  )
  print(retport_style)

  # Development environment report, and others:
  devtools::dev_sitrep()
  devtools::missing_s3()
  pak::pkg_deps_tree(".")
}


# C5. Package metadata:
if (FALSE) {
  repo_data <- repometrics::repometrics_data(".")
  pkg_data <- pkgstats::pkgstats()
  codemetar::write_codemeta(path = "personal/codemeta.json")
}



# B. Update Description, Packages, Version, and Releases -----------------------

# B1. Versioning and realeases:
if (FALSE) {
  # Versioning:
  desc <- desc::description$new()
  desc$get_version()
  desc$set_version(version)
  desc$bump_version(which = c("patch", "minor", "major", "dev"))

  # Releases:
  devtools::submit_cran() # Also consider `release()`
  usethis::use_github_release()
}


# B2. Package imports:
deps <- tibble::tribble(
  ~Type, ~Package, ~MinVersion,
  "Depends", "R", "4.0",
  #"Imports", "glue", NA,
  #"Suggests", "testthat", NA,
)

if (FALSE) {
  # Check the complexity of possible dependencies:
  pak::pkg_deps_tree("pkg_you_are_thinking_to_use")
  pak::pkg_deps_explain("pkg1", "pkg2")
  itdepends::dep_weight(deps$Package)

  # Dependencies:
  usethis::use_packages(deps)
  usethis::use_import_from("glue", "glue")

  # Installation via renv:
  renv::install()
  renv::update()

  # Consider adding standalone files via `use_standalone()`, `use_github_file()`
}


# B3. DESCRIPTION file:
if (FALSE) {
  desc <- desc::description$new()

  # Main fields:
  desc$set("Title", "What the Package Does (One Line, Title Case)")
  desc$set("Description", "What the package does (one paragraph).")
  desc$set_authors(c(
    person(
      "Ricardo", "Semião", role = c("aut", "cre"),
      email = "ricardo.semiao@outlook.com"
    )
  ))
  # Consider adding `comment = c(ORCID = "...")`
  desc$add_urls("URL", "https://example.com")

  # Mathjax, if required:
  usethis::use_package("mathjaxr", type = "Imports")
  desc$set("RdMacros", "mathjaxr")
  desc$set("BuildManual", "TRUE")
  # Finally, add `@importFrom mathjaxr preview_rd` somewhere

  # Consider other fields (https://r-pkgs.org/description.html#other-fields)

  # Writing: (maybe commit before)
  desc$normalize()
  desc$write()
}



# A. Package Setup -------------------------------------------------------------

if (FALSE) {
  # A1. Define its name:
  available::available("...")

  # A2. Create the package:
  usethis::create_package("testpkg", check_name = FALSE)
  # Also consider `create_tidy_package()`, but I prefer to set up manually

  # A3. Set up version control:
  usethis::use_git() # Or manually via `git init`
  # Setup github manually or via `use_github()`
  usethis::use_github_links() # Adds links to DESCRIPTION
  # Be wary about sensitive data, consider using `git_vaccinate()`
  # Consider using the git/github helpers usethis::pr_* and the ones at
  # (https://usethis.r-lib.org/reference/index.html#git-and-github)

  # A4. Set up main documentation:
  usethis::use_mit_license() # Consider other licenses
  usethis::use_readme_rmd()
  usethis::use_news_md()
  usethis::use_package_doc() # Then, populate this file with package-level docs
  # If you have a logo, conisder `use_logo()`
  usethis::use_lifecycle_badge("experimental")
  # If your package is released in some repository, consider using the other
  # badge functions

  # A5. Set up other infrastructure
  usethis::use_spell_check()
  usethis::use_revdep()
  usethis::use_lifecycle()
  usethis::use_testthat()
  usethis::use_pkgdown()
  # Consider the content-related helpers:
  # `use_cpp11()`, `use_c()` and friends, `use_make()`
  # `use_pipe()`, `use_tibble()`

  # A6. Set up CI/CD:
  usethis::use_coverage()
  usethis::use_github_action("check-standard")
  usethis::use_github_action("test-coverage")
  # Consider the {air} for styling with `use_air()`. I prefer to do it manually
  # If you want to use pkgdown with the standard Github pages scheme, consider
  # using `use_pkgdown_github_pages()`

  # Others:
  # - Helpers to set configurations options at
  # (https://usethis.r-lib.org/reference/index.html#configuration)
  # - Packages to switch practices: roxygen2md, prefixer, changer
  # - Add a tutorial via `use_tutorial()`
  # - If your package becomes big enough, consider adding a MAINTENANCE.md,
  # a code of conduct (`use_code_of_conduct()`), a contributing guide
  # (`use_tidy_contributing()`), and a citation file
  # - Add a `use_cran_comments()` before submitting to CRAN
  # - Add a cheatsheet

  # A7. Initial commit:
  # At the end, check if no file is being committed/builded when it should not:
  usethis::use_git_ignore(c("personal/"))
  usethis::use_build_ignore(c("personal/"))
}



# Appendix 1: Other Tips -------------------------------------------------------

# Other package-related tips:
# - Use renv (https://rstudio.github.io/renv/articles/packages.html) and maybe
# also {rig}.
# - In the README, refer to {pak} or {remotes} for installation instructions,
# not {devtools}.
# - Consider using the {config} package to manage environment-specific
# configurations, e.g. different settings for development and production.
# (https://rstudio.github.io/config/articles/config.html).
# - To think about dependencies, start by defining which packages are very
# essencial and you could not reproduce their functionality. Then, their
# dependencies (and their dependencies, and so on) are also packages that you
# can't avoid depending on, and thus its to also use as direct dependencies. See
# more on (https://r-pkgs.org/description.html#sec-description-imports-suggests-minium-version)

# Other function-related tips:
# - Creating custom checkers to reduce code repetition and improve consistency.
# Consider using {checkmate} for this.
# - Use documentation helpers that run via inline roxygen code, to reduce code
# repetition and improve consistency.
# - Add lifecycle badges to your functions. No need to repeat experimental if
# your whole package is experimental. Also use `deprecate_warn()` and friends
# (https://lifecycle.r-lib.org/articles/communicate.html).
# - Use benchmarks and profiling: {bench}, {profvis}, {memtools}, {lobstr},
# {log4r}, and {boomer}.
# - Use {cli} for nice command-line outputs, and {progressbar}. Use {pillar} and
# {downlint} for syntax highlighting and linking.
# - Try to add C/C++ code in performance-critical sections, preferably via
# {cleancall} and {cpp11}.


# Opinionated paradigms:
# - Use the {rlang} frameworks for metaprogramming, type-checking, and other
# high-quality utilities.
# - Use {vctrs} for ptypes concept and coercion.
# - Consider using S7 for OOP, or R6 if you need modify-in-place (often for
# performance).
# - Use {purrr}, {slider}, and {rlist} for functional programming.
# - For proeminent classes' manipulation, consider {stringr}, {forcats},
# {lubridate}, {hms} from the tidyverse; consider {bignum}, {sparsevctrs},
# {bit}, {blob}, and {fastmap} for more complex objects.
# - For data wrangling, consider {dplyr} + {tidyr}, but also more efficient
# alternatives like {data.table} or {collapse}, {r-polars}, {duckdb}, {sparklyr}
# {multidplyr}, note that all of them have transpilers from dplyr code.


# Templates for `.onLoad()` and `.onAttach()`:
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to my package")
}
.onLoad <- function(libname, pkgname) {
  rlang::run_on_load()
}
# Then use `rlang::on_load()` to register functions to be run at load time
# Also consider creating a `.onDetach` function


# Documentation tips:
# Use proto-type (as in {vctrs}) annotations on @params and @returns.
# In general, the proto-type indicates the essencial attributes
# (and type/length) that the input should have, while having extra attributes
# is usually acceptable. If that is not the case, specify it clearly in the text
#
# I don't really think the concept of "optional" arguments is often useful, just
# always specify the default value, if it exists, or what happens if it has a
# missing value.
#
# Examples of proto-type annotations:
# - [`integer()`]: a interger vector of any length
# - [`integer(1)`|`double(1)`]: a integer vector of length 1 or a double.
# - [`matrix(integer(), 2, 3)`]: a matrix of integers with 2 rows and 3 columns.
# - [`matrix(, 2, 3)`]: a matrix with 2 rows and 3 columns. I.e. an object with
# with variable type and a specific "dim" attribute.
# - [`list(x = integer(), y = character())`]: a list with columns `x` and `y` of
# types integer and character, respectively. This can get kind of verbose for
# big lists/data.frames, and is probably better to describe each list/data.frame
# element in a markdown list.
# - [`list(1)`]: you can perhaps abuse the notation to indicate a list of length
# 1 with an element of any type.
#
# If you have more specific requirements, often is better to describe them in
# the text. Also consider [`integer()`-bare] to indicate that the input should
# not have any extra attributes on top of what the proto-type has. Often this is
# only enforced for the more important "class" attribute.
#
# You can also cite topics, e.g. <[`data-masking`][rlang::args_data_masking]>.



# Appendix 2: Utility Functions ------------------------------------------------

# Function to update package dependencies to minimum major version available
# `pkgs` should be a data.frame. The third column can have the value
# "latest_major" to set the minimum version to the latest major version
use_packages <- function(pkgs = NULL) {
  purrr::pwalk(deps, \(Type, Package, MinVersion) {
    MinVersion <- if (is.na(MinVersion)) {
      NULL
    } else if (MinVersion == "latest_major") {
      gsub("([0-9]+)\\.[0-9]+\\.[0-9]+", "\\1.0.0", packageVersion(Package))
    } else {
      MinVersion
    }
    usethis::use_package(Package, type = Type, min_version = MinVersion)
  })
}

# Function to summarize linting, coverage, and spelling reports into a single
# table and save it as a CSV file
summarize_reports <- function(res_lint, res_covr, res_spell, path) {
  # Relevant files:
  filenames <- list(
    man = list.files("man"),
    R = list.files("R"),
    vignettes = list.files("vignettes"),
    c("README.Rmd", "NEWS.md", "DESCRIPTION") # Also consider LICENSE.md, LICENSE
  ) |>
    unlist() |>
    Filter(x = _, \(x) tools::file_ext(x) %in% c("R", "Rd", "Rmd", "qmd", "md", ""))
  folders <- substr(names(filenames), 1, nchar(names(filenames)) - 1)

  filenames <- filenames |>
    strsplit("/") |>
    vapply(character(1), FUN = \(x) tail(x, 1))
  names(filenames) <- paste0(folders, "/", filenames)

  # Lint, coverage, and spelling:
  lint_data <- summary(res_lint)
  lint_data <- rbind(
    lint_data,
    c(filenames = list("Total"), apply(lint_data[-1], 2, sum))
  )

  covr_data <- covr::coverage_to_list(res_covr)
  covr_data <- data.frame(
    file = c(names(covr_data$filecoverage), "Total"),
    coverage = c(covr_data$filecoverage, covr_data$totalcoverage)
  ) |>
    setNames(c("filenames", "coverage"))

  spell_data <- sapply(res_spell$found, FUN = \(x) {
    stringr::str_split_fixed(x, ":", 2)[, 1] |>
      factor(levels = filenames) |>
      table()
  }) |>
    apply(1, sum)
  spell_data <- data.frame(
    filenames = c(names(filenames), "Total"),
    spell = c(spell_data, sum(spell_data))
  )

  # Merging all:
  report <- lint_data |>
    merge(covr_data, all = TRUE, by = "filenames") |>
    merge(spell_data, all = TRUE, by = "filenames")
  report <- report[match(c(names(filenames), "Total"), report$filenames), ] |>
    `rownames<-`(NULL)

  cat("Diagnostics report: (saved at", path, ")")
  report |>
    apply(2, \(x) ifelse(is.na(x), "", x)) |>
    knitr::kable(align = "lccccc")

  write.csv(report, path)
  invisible(report)
}
