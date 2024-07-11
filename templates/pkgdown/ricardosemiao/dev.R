reticulate::py_run_string("
from template_injector import build
build(
  'assets/layout_template.html',
  ['assets/components.html'],
  'inst/pkgdown/templates/BS5/layout.html'
)
")
