library(glue)

files <- c("head", "layout") #, "navbar"

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'templates/pkgdown/rspkgdown/assets/{f}_template.html',
    ['site_assets/components.html',
    'templates/pkgdown/rspkgdown/assets/rspkgdown_components.html'],
    'templates/pkgdown/rspkgdown/inst/pkgdown/BS5/templates/{f}.html'
  )
  "))
}

devtools::install("templates/pkgdown/rspkgdown")
