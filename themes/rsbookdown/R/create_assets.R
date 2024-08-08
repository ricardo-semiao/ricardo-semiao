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
  assets_path <- system.file("inst/assets", package = "bookdown")

  files <- list.files(assets_path, full.names = TRUE)

  for (file in files) {
    file.copy(file, ".", overwrite = overwrite_ok)
  }

  message("Assets copied successfully.")
}
