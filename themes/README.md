# Themes

This is the Themes folder of my personal repository. Below, I list its contents.

The file [site_components.html](components.html) is a hardlink of the [components file](https://github.com/ricardo-semiao/ricardo-semiao.github.io/blob/main/site_assets/components.html) used to build my personal site. It is used to [inject](../packages/template_injector) the components of into the templates of my themes.


## [palette](themes\palette)

This folder contains my personal palette, lightly inspired in ColorBrewer's "Dark 2".

- The main colors are defined, and variations of them are programmatically created with a SASS script.
- The palette can be visualized with a toy HTML script.
- The original CSS palette is converted to other languages, such as TEX, via the "dev.py" script.


## [dev_rpack.R](themes\dev_rpack.R)

An R script with the workflow I use to develop R packages. Inspired by the information on the great ["R Packages (2e)"](https://r-pkgs.org/) book, from Hadley Wickham and Jennifer Bryan. It heavily uses the [devtools](https://devtools.r-lib.org/) package.


## [rspkgdown](themes\rspkgdown)

A custom [R pkgdown](https://pkgdown.r-lib.org/) template that morphs into my personal website. It follows a the R package structure required by pkgdown.

It is currently used to build the site for my packages [mtsdesc](https://ricardo-semiao.github.io/mtsdesc/), [phyopt](https://ricardo-semiao.github.io/phyopt/), and [morphdown](https://ricardo-semiao.github.io/morphdown/).


## [rsquartobook](themes\rsquartobook)

A custom [Quarto book](https://quarto.org/docs/books/) template that morphs into my personal website. Currently, I create a junction of the [assets](themes\rsquartobook\assets) folder into the assets folder of the given book. Soon I'll create a better approach to serve the theme, and even update the `_quarto.yml` file of the book.

It has the additional [adust_links.py](themes\rsquartobook\template\adust_links.py) file that ensures that the links referring to the site's root directory aren't replaced by the book's root directory (i.e. turns `./some/link/at/the/template` back to `/some/link/at/the/template`).


## [rsbookdown](themes\rsbookdown)

A custom [R bookdown](https://bookdown.org/) template that morphs into my personal website. Bookdown does not natively support package templates, so this is just a package that copies the assets in a specific folder.

It is currently used to build the site for my [RFCD](https://ricardo-semiao.github.io/course-rfcd/) book. R bookdown is an older approach, and soon I'll switch the book to a Quarto book.


## [office](themes\office)

This folder contains my Microsoft Office templates.


## Future Projects

In the future, I intent to create lots of templates for lots of tools such as: R's ggplot2, TEX, Quarto revealjs, and others.
