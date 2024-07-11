
reticulate::py_run_string("
from template_injector import build
build(
  'templates/pkgdown/ricardosemiao/assets/layout_template.html',
  ['site_assets/components.html',
  'templates/pkgdown/ricardosemiao/assets/ricardosemiao_components.html'],
  'templates/pkgdown/ricardosemiao/inst/pkgdown/BS5/templates/layout.html'
)
")

devtools::install("templates/pkgdown/ricardosemiao")
