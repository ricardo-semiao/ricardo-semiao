---
applyTo: '**/*.R,**/*.Rmd'
---

# Guidelines for R Programming

Abide to the [general_programming instructions](./general_programming.instructions.md) and the following R-specific instructions.

## Style Guide

- A line should not exceed 80 characters.
- Always put a space after a comma, never before, just like in regular English.
- Divide code sections with a comment like `# Section Name ---`, in Title Case, with dashes completing the line.
- For function calls too long to fit on a single line: use one line for the function name and closing `)`, at the current indent level, and one line for each group of arguments, at the next indent level. Arguments closely related to eachother can be grouped on the same line.
- Naming conventions:
    - Variables and functions should be named using `snake_case`.
    - Dataframes columns should be named using `CamelCase`.

### Functions

- Strive to use verbs for function names
- Use lambda syntax `\(x) x + 1` 1-line anonymous functions and only that case.


## Functionality preferences

- Pipe: prefer the base pipe `|>` over `magrittr::%>%`, even if the existing code does not.
- String interpolation: prefer `glue()` over `paste0()`.
- Condition functions: for non-vectorized conditions, use the infix form of `if`, `` `if`(cond, true, false)``. For single vectorized conditions, prefer `dplyr::if_else()` over `ifelse()`. For multiple conditions, prefer `dplyr::case_when()`.
