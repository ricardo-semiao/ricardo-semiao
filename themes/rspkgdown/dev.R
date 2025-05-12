library(glue)

files <- c("head", "layout") #, "navbar"

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'themes/rspkgdown/assets/{f}_template.html',
    ['themes/site_components.html',
    'themes/rspkgdown/assets/rspg_components.html'],
    'themes/rspkgdown/inst/pkgdown/BS5/templates/{f}.html'
  )
  "))
}

file.copy(
  "themes/rspkgdown/assets/rspg_style.css",
  "themes/rspkgdown/inst/pkgdown/BS5/assets/rspg_style.css",
  overwrite = TRUE
)

devtools::install("themes/rspkgdown")
