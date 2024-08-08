library(devtools)

#create("themes/rsbookdown")

reticulate::py_run_string("
from template_injector import build
build(
  'themes/rsbookdown/template_build/rsbookdown_layout_template.html',
  ['themes/components.html',
  'themes/rsbookdown/template_build/rsbookdown_components.html'],
  'themes/rsbookdown/inst/bookdown/assets/rsbookdown_layout.html'
)
")

load_all("themes/rsbookdown")
document("themes/rsbookdown")
check("themes/rsbookdown")
install("themes/rsbookdown", upgrade = FALSE)
