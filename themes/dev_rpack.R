
# Setup ------------------------------------------------------------------------

library(devtools)
library(pkgdown)
#library(vdiffr) for graphic tests

use_package_min <- function(pkgs = NULL, type = "Imports") {
  if (is.null(pkgs)) return(invisible(NULL))
  min_versions <- purrr::map(pkgs, ~ gsub("([0-9]+)\\.[0-9]+\\.[0-9]+", "\\1.0.0", packageVersion(.x)))
  purrr::walk2(pkgs, min_versions, ~ use_package(.x, type = type, min_version = .y))
}



# Informal testing -------------------------------------------------------------

load_all()
document()
#mathjaxr::preview_rd("path", type = "html", verbose = TRUE)



# Updating ---------------------------------------------------------------------

load_all()
document()

test()
run_examples()

check() #check_dir = "personal/"
install(upgrade = FALSE)

build_readme()
build_vignettes()
build_site(preview = FALSE)
build_manual() #path = "personal/"



# Creating Files ---------------------------------------------------------------

# Creating
if (FALSE) {
  use_r("name")
  use_test("empty_test")
  use_vignette("example")
  use_article("name")
  #use_data_raw(); use_data()
}

if (FALSE) {
  styling_report <- styler::style_pkg(
    scope = "line_breaks",
    style = tidyverse_style,
    strict = TRUE
  )
  spell_check()
  lintr::lint_package(path = ".")
}



# Package setup ----------------------------------------------------------------

# General
if (FALSE) {
  # Creating:
  available::available("...")
  create_package("...")

  # Git:
  use_git()
  git_vaccinate()
  use_github_action_check_standard() #use_github_action()

  # Document:
  use_roxygen_md()
  use_package_doc()
  use_tidy_description()
  use_mit_license()

  # Readmes:
  use_readme_rmd()
  use_news_md()
  use_lifecycle_badge("experimental")
  use_cran_badge()

  # Site:
  use_pkgdown()
  use_pkgdown_github_pages()

  # Tests:
  use_testthat(3)
  local_use_cli()

  # Mathjax:
  #add to imports
  #add `RdMacros: mathjaxr` and `BuildManual: TRUE` in DESCRIPTION
  #add `@importFrom mathjaxr preview_rd` somewhere
}


# Package imports
depends <- c("rlang", "purrr")
imports <- c("cli", "glue", "mathjaxr")
suggests <- c()

if (FALSE) {
  use_package_min(depends, "Depends")
  use_package_min(imports, "Imports")
  use_package_min(suggests, "Suggests")
  use_package("R", type = "Depends", min_version = "4.3")
}


# Function imports
use_import_from("glue", "glue")
