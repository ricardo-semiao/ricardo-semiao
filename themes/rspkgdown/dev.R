library(devtools)
library(glue)

# Building templates
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


# Copying assets to package folders
file.copy(
  "themes/rspkgdown/assets/rspg_style.css",
  "themes/rspkgdown/inst/pkgdown/BS5/assets/rspg_style.css",
  overwrite = TRUE
)

# Building package
install("themes/rspkgdown")
