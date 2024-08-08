# Themes

This is the Themes folder of my personal repository. Below, I list its contents.

The file [components.html](components.html) is a hardlink of the [components file](https://github.com/ricardo-semiao/ricardo-semiao.github.io/blob/main/site_assets/components.html) used to build my personal site. It is refered to by "rspkgdown" and "rsbookdown".


## office

This folder contains my Microsoft Office templates.


## palette

This folder contains my personal palette, lightly inspired in ColorBrewer's "Dark 2".

The main colors are defined, and variations of them are programmatically created with a SASS script.

The palette can be visualized with a toy HTML script.

The original CSS palette is converted to other languages, such as TEX, via the "dev.py" script.


## rspkgdown

A custom [R pkgdown](https://pkgdown.r-lib.org/) template that morphs into my personal website. It is currently used to build the site for my packages [varr](https://ricardo-semiao.github.io/varr/) and [morphdown](https://ricardo-semiao.github.io/morphdown/).

The layout HTML/pandoc scripts are injected using my "template_injector" package.


## rsbookdown

A custo [R bookdown](https://bookdown.org/) template that morphs into my personal website. It is currently used to build the site for my [RFCD](https://ricardo-semiao.github.io/RFCD/) book.

The layout HTML/mustache scripts are injected using my "template_injector" package.

Bookdown does not natively support package templates, so this is just a package that copies the assets in a specific folder. In the future, I'll make a function to update the "_output.yml" file too.


## Future Projects

In the future, I intent to create lots of templates for lots of tools such as: R's ggplot2, TEX, Quarto (book, presentations, etc.).
