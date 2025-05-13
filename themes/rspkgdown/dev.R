library(devtools)
library(glue)

# Building templates
files <- c("head", "layout")

for (f in files) {
  reticulate::py_run_string(glue("
  from template_injector import build
  build(
    'themes/rspkgdown/assets/{f}_template.html',
    ['themes/site_components.html',
    'themes/rspkgdown/assets/rspg_components.html'],
    'themes/rspkgdown/inst/pkgdown/templates/{f}.html'
  )
  "))
}


# Copying assets to package folders
file.copy(
  "themes/rspkgdown/assets/rspg_style.css",
  "themes/rspkgdown/inst/pkgdown/assets/rspg_style.css",
  overwrite = TRUE
)

# Building package
load_all("themes/rspkgdown")
document("themes/rspkgdown")
check("themes/rspkgdown")
install("themes/rspkgdown", upgrade = FALSE)
