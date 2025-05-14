#' Copy assets from package to current directory
#'
#' This function copies assets from the package to the current working
#' directory. The assets are located in the "inst/assets" directory of the
#' package.
#'
#' @param output_path The path to the directory where the assets should be copied.
#' @param overwrite_ok Should files be overwritten?
#'
#' @return NULL
#'
#' @export
copy_assets <- function(output_path = "./assets/template", overwrite_ok = FALSE) {
  assets_path <- system.file("bookdown/assets", package = "rsbookdown")

  files <- list.files(assets_path, full.names = TRUE)

  for (file in files) {
    file.copy(file, file.path(output_path, basename(file)), overwrite = overwrite_ok)
  }

  message("Assets copied successfully.")
}
