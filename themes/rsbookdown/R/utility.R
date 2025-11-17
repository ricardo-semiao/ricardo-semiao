#' Copy assets from package to current directory
#'
#' This function copies assets from the package to the current working
#' directory. The assets are located in the "inst/assets" directory of the
#' package.
#'
#' @param output_path The path to the directory where the assets should be
#' copied.
#' @param overwrite_ok Should files be overwritten?
#'
#' @return NULL
#' @export
copy_assets <- function(
  output_path = "./assets/template",
  overwrite_ok = FALSE
) {
  assets_path <- system.file("bookdown/assets", package = "rsbookdown")

  files <- list.files(assets_path, full.names = TRUE)

  for (file in files) {
    file.copy(
      file,
      file.path(output_path, basename(file)),
      overwrite = overwrite_ok
    )
  }

  message("Assets copied successfully.")
}


#' Create a `_bookdown.yml` file
#'
#' This function generates a `_bookdown.yml` file in the specified directory
#' with metadata about the last build time.
#'
#' @param path [`character(1)`] The directory path where the `_bookdown.yml`
#'   file will be created.
#'
#' @returns [`NULL`] Invisibly returns `NULL` after creating the file.
#' @export
create_bookdown_yml <- function(path) {
  writeLines(
    paste0("last_built: ", format(Sys.time(), "%Y-%m-%dT%H:%MZ")),
    paste0(gsub("/|\\\\$", "", path), "/bookdown.yml")
  )

  invisible(NULL)
}

#' @keywords internal
create_sitemap_xml <- function(path) {
  stop("Not implemented yet.")
  if (FALSE) {
    files <- paste0("./", list.files("docs", pattern = "\\.html$")) |> sort()
    # Something with xml2
  }
}
