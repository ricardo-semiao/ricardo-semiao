
# Setup ------------------------------------------------------------------------

library(glue)
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

fetch_global_assets("themes/rspkgdown/inst/pkgdown/assets/assets/", FALSE)



# Building and Compiling Assets ------------------------------------------------

files <- c("head", "layout")
components_path <- "../ricardo-semiao.github.io/src/global/"

for (f in files) {
  py_run_string(glue("
  from template_injector import build
  build(
    'themes/rspkgdown/assets/{f}.html',
    [
      '{components_path}global_components.html',
      'themes/rspkgdown/assets/rspd_components.html'
    ],
    'themes/rspkgdown/inst/pkgdown/templates/{f}.html'
  )
  "))
}


# Compiling sass to package folder
system(paste(
  "sass",
  "themes/rspkgdown/assets/rspd_module.scss",
  "themes/rspkgdown/inst/pkgdown/assets/assets/rspd_module.css",
  "--no-source-map"
))

# Copying assets to package folders
file.copy(
  "themes/rspkgdown/assets/rspd_module.js",
  "themes/rspkgdown/inst/pkgdown/assets/assets/rspd_module.js",
  overwrite = TRUE
)



# Building and Compiling Assets ------------------------------------------------

#devtools::load_all("themes/rspkgdown")
devtools::document("themes/rspkgdown")
#devtools::check("themes/rspkgdown")
devtools::install("themes/rspkgdown", upgrade = FALSE)
