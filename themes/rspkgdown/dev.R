library(glue)

files <- c("head", "layout") #, "navbar"

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'themes/rspkgdown/template_build/{f}_template.html',
    ['themes/components.html',
    'themes/rspkgdown/template_build/rspkgdown_components.html'],
    'themes/rspkgdown/inst/pkgdown/BS5/templates/{f}.html'
  )
  "))
}

devtools::install("themes/rspkgdown")
