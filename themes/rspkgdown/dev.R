library(glue)

files <- c("head", "layout") #, "navbar"

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'themes/rspkgdown/assets/{f}_template.html',
    ['site_assets/components.html',
    'themes/rspkgdown/assets/rspkgdown_components.html'],
    'themes/rspkgdown/inst/pkgdown/BS5/templates/{f}.html'
  )
  "))
}

devtools::install("themes/rspkgdown")
