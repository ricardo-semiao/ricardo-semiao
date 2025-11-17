
# Setup ------------------------------------------------------------------------

library(reticulate)
use_python("C:/Python310")



# Fetching Personal Assets -----------------------------------------------------

fetch_global_assets <- function(path, remote = TRUE) {
  lapply(c("global.css", "global.js"), \(asset_name) {
    file <- if (remote) {
      readLines(paste0("https://ricardo-semiao.github.io/assets/", asset_name))
      # Read global components from git
    } else {
      readLines(paste0("../ricardo-semiao.github.io/_dist/assets/", asset_name))
    }
    writeLines(file, paste0(path, asset_name))
  })

  invisible(NULL)
}

fetch_global_assets("themes/rsbookdown/inst/bookdown/assets/", FALSE)



# Building and Compiling Assets ------------------------------------------------

# Building templates
components_path <- "../ricardo-semiao.github.io/src/global/"

py_run_string(glue("
from template_injector import build
build(
  'themes/rsbookdown/assets/rsbd_template.html',
  [
    '{components_path}global_components.html',
    'themes/rsbookdown/assets/rsbd_components.html'
  ],
  'themes/rsbookdown/inst/bookdown/assets/rsbd_template.html'
)
"))


# Compiling sass to package folder
system(paste(
  "sass",
  "themes/rsbookdown/assets/rsbd_module.scss",
  "themes/rsbookdown/inst/bookdown/assets/rsbd_module.css",
  "--no-source-map"
))


# Copying assets to package folders
file.copy(
  "themes/rsbookdown/assets/rsbd_module.js",
  "themes/rsbookdown/inst/bookdown/assets/rsbd_module.js",
  overwrite = TRUE
)



# Building Package -------------------------------------------------------------

#devtools::load_all("themes/rsbookdown")
devtools::document("themes/rsbookdown")
#devtools::check("themes/rsbookdown")
devtools::install("themes/rsbookdown", upgrade = FALSE)
