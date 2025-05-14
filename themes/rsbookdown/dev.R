library(devtools)

# Building templates
reticulate::py_run_string("
from template_injector import build
build(
  'themes/rsbookdown/assets/rsbd_layout_template.html',
  ['themes/site_components.html',
  'themes/rsbookdown/assets/rsbd_components.html'],
  'themes/rsbookdown/inst/bookdown/assets/rsbd_layout.html'
)
")


# Compiling sass to package folder
system(paste(
  "sass",
  "themes/rsbookdown/assets/style_scss.scss",
  "themes/rsbookdown/inst/bookdown/assets/rsbd_style.css",
  "--no-source-map"
))


# Copying assets to package folders
file.copy(
  "themes/rsbookdown/assets/rsbd_script.js",
  "themes/rsbookdown/inst/bookdown/assets/rsbd_script.js",
  overwrite = TRUE
)


# Building package
load_all("themes/rsbookdown")
document("themes/rsbookdown")
check("themes/rsbookdown")
install("themes/rsbookdown", upgrade = FALSE)
