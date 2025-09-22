---
applyTo: "**/*.md, **/*.qmd, **/*.Rmd, **/*.tex"
---

# Guidelines for Markdown and Latex Editing

## General guidelines

- When asked to add a yaml header, the first and last lines must be `---`.
- When adding yaml options, note that yaml variables are often, not always, separated by hyphens.
- When altering code chunks, do not override the chunk borders '```'.
- When adding latex or html, add them raw, without chunk borders '```'.
- When writing latex math, always and only use `$` or `$$` as the math mode delimiters.
- When writing latex math, always and only use one or more '~' as spacers.

## Chat message guidelines

- When returning latex math in the chat, always and only return the raw, unformatted latex. Always and only use the `$` or `$$` delimiters.
- When asked to update a part of a markdown file, always and only return the raw, unformatted markdown code, within a code block '```'.
