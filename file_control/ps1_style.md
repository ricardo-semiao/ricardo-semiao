# Conventions for My PowerShell Scripts

## Casing

- snake_case for filenames.
- PascalCase for functions, classes, and arguments.
- camelCase for inner variables.


## Argument Names and Order

- `Path` or `Paths`: if needed, should always be the first argument.
- `PathsKeep` and `PathsRemove`: if needed, should always be the second and third arguments.
- `OutputPath`: if needed, should always be the last argument.
- All of the above should not have default values.


## Commenting

- There should always be comments, but only minimal/necessary ones.
- The calling of functions at the end of the script should be commented `# Application:`.


## Others

- If the function returns a value, the `return` flag should be used.
- Logs should always use `Write-Host`.
- `Encoding UTF8` should always be used for text file creation.
