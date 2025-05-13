#' Re-Wrap rspkgdown main page content into `div#site-main`
#'
#' This function modifies HTML files in the `docs/` directory by wrapping
#'  the `body>nav.navbar` and `body>div.container` elements into a new
#'  `div#site-main` element, as is required by the rspkgdown template.
#'
#' @param pkgname A character string specifying the package name. Defaults
#'   to the name of the current working directory.
#'
#' @details
#' Even though the rspkgdown template already provides a `div#site-main`,
#'  some pkgdown logic removes it. This function restores it.
#'
#' @export
rewrap_content <- function(pkgname = basename(getwd())) {
  message("Sucessfully wrapped `body>nav.navbar` and `body>div.container` into `div#site-main` for:")

  html_paths <- list.files("docs/", pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
  html_paths <- setdiff(html_paths, paste0("docs/reference/", pkgname, ".html"))

  for (path in html_paths) {
    html_content <- xml2::read_html(path)
    body_node <- xml2::xml_find_first(html_content, ".//body")

    navbar <- xml2::xml_find_first(body_node, "nav[contains(@class, 'navbar')]")
    container <- xml2::xml_find_first(body_node, "div[contains(@class, 'container')]")

    site_main <- xml2::xml_new_root("div", id = "site-main")
    xml2::xml_add_child(site_main, navbar)
    xml2::xml_add_child(site_main, container)

    xml2::xml_add_sibling(xml2::xml_find_first(body_node, "a"), site_main, .where = "after")
    xml2::xml_remove(container)
    xml2::xml_remove(navbar)

    xml2::write_html(html_content, path)
    message("  -> ", path)
  }
}


#' Re-add package title to an rspkgdown index.html
#'
#' This function re-adds the package title to the `docs/index.html` file of a 
#' rspkgdown-generated site. It modifies the HTML structure by inserting the 
#' package title as a header at the beginning of the main content section.
#'
#' @param pkgname A character string specifying the package name. Defaults to 
#'   the name of the current working directory.
#'
#' @details
#' Some interaction between pkgdown and the rspkgdown template removes the
#'  package title from the `docs/index.html` file. This function restores it.
#'
#' @export
readd_pkg_title <- function(pkgname = basename(getwd())) {
  pkgname_html <- paste0(
    '<div class="page-header"><h1 id="', pkgname,
    '">', pkgname,
    '<a class="anchor" aria-label="anchor" href="#', pkgname,
    '"></a></h1></div>'
  )
  pkgname_html <- xml2::xml_find_first(xml2::read_html(pkgname_html), ".//div")

  index_content <- xml2::read_html("docs/index.html")
  site_main <- xml2::xml_find_first(index_content, ".//main[@id='main']/div[contains(@class, 'section')]")

  xml2::xml_add_child(site_main, pkgname_html, .where = 0)
  xml2::write_html(index_content, "docs/index.html")

  message("Sucessfully re-added package title to 'docs/index.html'.")
}
