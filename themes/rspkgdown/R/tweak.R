#' Tweak links in HTML files within subfolders.
#'
#' This function patches issues where `pkgdown::tweak_link_absolute()` and the
#' `{{#site}}{{root}}{{/site}}` template do not work, typically when the user
#' has not set a URL in the pkgdown meta configuration. It locates all `.html`
#' files in subfolders of the specified folder and prepends `"../"` to the
#' `src` and `href` attributes of elements matching the given CSS selector.
#' Matching elements are found using `xml2::xml_find_all()`.
#'
#' Be careful: this function restyles the html file.
#'
#' @param selector [`character(1)`] CSS selector used to identify elements whose
#'  `src` or `href` attributes should be tweaked.
#' @param folder [`character(1)`] [optional] Path to the root folder containing
#'  HTML files. Defaults to `"docs"`.
#'
#' @returns [`NULL`] This function is called for its side effects and returns
#'  `NULL`.
#' @export
tweak_link_subfolders <- function(selector, folder = "docs") {
  # Get all .html files in subfolders of folder
  html_files <- list.files(
    path = folder, pattern = "\\.html$",
    recursive = TRUE, full.names = TRUE
  )
  parts_after_folder <- vapply(
    strsplit(gsub(paste0(".*", folder, "/(.+)"), "\\1", html_files), "/"),
    length, integer(1)
  )
  html_files <- html_files[parts_after_folder == 2]
  # Nothing is done for files more than 2 levels deep, they shouldnt exist

  # For each file, tweak matching elements
  for (file in html_files) {
    doc <- xml2::read_html(file)
    nodes <- xml2::xml_find_all(doc, selector)

    for (node in nodes) {
      # Prepend "../" to src attribute if present
      src <- xml2::xml_attr(node, "src")
      if (!is.na(src)) {
        xml2::xml_set_attr(node, "src", paste0("../", src))
      }
      # Prepend "../" to href attribute if present
      href <- xml2::xml_attr(node, "href")
      if (!is.na(href)) {
        xml2::xml_set_attr(node, "href", paste0("../", href))
      }
    }

    xml2::write_html(doc, file)
  }
}

#' Add navbar id for accessibility in HTML files.
#'
#' This function sets the `id` attribute of the navbar element in HTML files
#' within the specified folder to `"pkgdown-navbar"`. This is required for
#' the `aria` target of the show-navbar button to work correctly. The navbar
#' element is identified using an XPath query for elements with `id` equal to
#' `"rspkgdown-main"` and a `nav` child containing the `"navbar"` class.
#' Matching elements are found using `xml2::xml_find_all()`.
#'
#' @param folder [`character(1)`] [optional] Path to the root folder containing
#'   HTML files. Defaults to `"docs"`.
#'
#' @returns [`NULL`] This function is called for its side effects and returns
#'   `NULL`.
#' @export
tweak_navbar_id <- function(folder = "docs") {
  html_files <- list.files(
    path = folder, pattern = "\\.html$",
    recursive = TRUE, full.names = TRUE
  )

  for (file in html_files) {
    doc <- xml2::read_html(file)
    nav <- xml2::xml_find_all(
      doc,
      '//*[@id="rspkgdown-main"]/nav[contains(@class, "navbar")]'
    )
    xml2::xml_set_attr(nav, "id", "pkgdown-navbar")
    xml2::write_html(doc, file)
  }
}

#' Tweak home page title.
#' Should be unneeded.
tweak_home_title <- function(title = NULL) {
  title <- title %||% pkgdown::as_pkgdown(".")$package

  doc <- xml2::read_html("docs/index.html")
  main_node <- xml2::xml_find_first(doc, '//*[@id="main"]')

  h1_node <- xml2::xml_new_root("h1")
  xml2::xml_text(h1_node) <- title
  xml2::xml_add_child(main_node, h1_node, .where = 0)

  xml2::write_html(doc, "docs/index.html")
}
