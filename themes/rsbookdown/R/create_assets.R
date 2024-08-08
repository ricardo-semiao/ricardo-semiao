#' Copy assets from package to current directory
#'
#' This function copies assets from the package to the current working
#' directory. The assets are located in the "inst/assets" directory of the
#' package.
#' 
#' @param overwrite_ok Should files be overwritten?
#'
#' @return NULL
#'
#' @export
copy_assets <- function(overwrite_ok = FALSE) {
  assets_path <- system.file("bookdown/assets", package = "rsbookdown")

  files <- list.files(assets_path, full.names = TRUE)

  for (file in files) {
    file.copy(file, "./assets", overwrite = overwrite_ok)
  }

  message("Assets copied successfully.")
}


#' Update _output.yml with theme template
#'
#' Not yet finished.
#'
#' @noRd
add_template_yml <- function(output, overwrite_ok = FALSE) {
  yml <- readLines("_output.yml")

  grepl(paste0("^", output, ":"), yml)
}