library(glue)

files <- c("head", "layout") #, "navbar"

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'templates/rspkgdown/assets/{f}_template.html',
    ['site_assets/components.html',
    'templates/rspkgdown/assets/rspkgdown_components.html'],
    'templates/rspkgdown/inst/pkgdown/BS5/templates/{f}.html'
  )
  "))
}

devtools::install("templates/rspkgdown")
