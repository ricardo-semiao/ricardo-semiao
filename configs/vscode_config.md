# VSCode Configuration

This document describes my configuration of Visual Studio Code, my main programming tool.



## Documentation Comments

Some of the main documentation pages I'm yet to study:

- [Tasks](https://code.visualstudio.com/docs/debugtest/tasks) and [Tasks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_task-runner).
- [Snippets](https://code.visualstudio.com/docs/editing/userdefinedsnippets) and [Commands](https://code.visualstudio.com/docs/configure/keybindings#_command-arguments)
- [Debugging](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_debugging).
- [Profiles](https://code.visualstudio.com/docs/configure/profiles) and [template profiles](https://code.visualstudio.com/docs/configure/profiles#_python-profile-template).
- Copilot [tricks](https://code.visualstudio.com/docs/copilot/copilot-tips-and-tricks) and [customization](https://code.visualstudio.com/docs/copilot/copilot-customization).
- [Terminals](https://code.visualstudio.com/docs/terminal/basics#_managing-terminals).

Useful features to keep in mind:

- [Combining logs](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_combine-multiple-logs-into-a-single-view).
- [File associations](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_file-associations).



## Configurations To-Dos

Some of the setting up I still intend to do:

- Create tasks
- Create launch configs
- Create snippets and commands
- Wrap all in profiles

And some minor ones:

- Add more file types to ctrl + N.
- Control context menu
- Control showing in activity bar



## Constructs

Settings defining 'constructs', not behavior.


### Launch Configurations

To-do


### Terminals

- Created terminals via `"terminal.integrated.profiles.windows"`, for PS7, PS5.1, R (radian), Python, and Julia.


### Latex Recipes

- Removed unused ones.



## Settings

Lots of settings, separated into categories in my `settings.json`.


### Useful At Default

- `"editor.fastScrollSensitivity"`
- `"explorer.sortOrder"`: `"type"`
- `"editor.cursorStyle"` and `"editor.cursorBlinking"`


### Settings To-Do

- Chat attatch instructions
- usesOnlineServices?


## Keybindings

### Custom Keybindings

- Emphasis for markdown and latex: `Ctrl + Shift + I` and `Ctrl + Shift + B`.
- Send code to terminal: `Ctrl + Enter` (standardize to all languages).
- Open md preview to the side: `Ctrl + K V` (add to Quarto too).


### Basic Keybindings

#### File

- `N`ew file and window: `Ctrl + N` and `Ctrl + Shift + N`.
- Close file: `Ctrl + F4`.
- Reopen closed editor: `Ctrl + Shift + T`.
- `R`eopen recently opened files: `Ctrl + R`.
- `S`ave and save as: `Ctrl + S` and `Ctrl + Shift + S`.
- Open:
    - Settings JSON and UI:
    - Keybindings JSON and UI:
    - Snippets JSON:

#### Edit

- Copy, cut, and Paste: `Ctrl + C`, `Ctrl + X`, and `Ctrl + V`.
- Undo and Redo: `Ctrl + Z` and `Ctrl + Shift + Z`.
- Find: `Ctrl + F`.
- Comment line and block toggle: `Ctrl + /` and `Ctrl + Alt + /`.
- Transform to case:
- Code formatting:
- Edits:
    - Intellisense: `?`; Request completion: `Ctrl + Space`.
    - Emmet:
    - Copilot:; Accept next word: `Ctrl + rightarrow`

#### Selection

- Select `a`ll: `Ctrl + A`.
- Selecting text: `Shift/Ctrl + mouse` + `Shift + arrows` and `Shift + Ctrl + side arrows`.
- Move and copy lines: `Alt + vertical arrows` and `Alt + Shift + vertical arrows`.
- Multiple cursor selection: `Shift + Alt + mouse`.
- Fast scroll: `Alt + scroll`.
- Select all, next, and previous occurrences:
- Add cursor above, below, and to line end:
- Select current line: ? Ctrl+L
- Select up to start and till end: `Ctrl + Home` and `Ctrl + End`.


#### View

- Fullscreen and zen mode: `F11` and `Alt + F11`.
- Zoom in and out: `Ctrl + =` and `Ctrl + -`.
- Toggle sidebar and alternative sidebar: `Ctrl + B` and `Ctrl + Alt + B`.
- Toggle panel: `` Ctrl + ` ``.
- Word wrap: `Alt + Z`.

#### Go

- Open: `Ctrl + P`.
    - Command palette (open + `>`): `Ctrl + Shift + P`.
    - Symbol in file and in workspace: Open + `@` (`@:`) and `#`.
    - Line number: Open + `:`.
    - Command suggestions: Open + `?`.
- View and peek definition: `Ctrl + mouse`/`F12` and `Alt + F12`.
- Peek references or implementations: `Shift + F12` or `Ctrl + F12`.
- Open and move editors:


#### Run

- "Debug" section.
- run task?
- run current file?

#### Terminal

- Run selected text: `Ctrl + Enter`.
- Open external terminal `` Ctrl + Alt + ` ``.


#### Copilot

- Show diff view for suggestions: `F7`.

#### Others

- Compare with clipboard and saved: `Ctrl + K + C` and `Ctrl + K + D`.
- Copy relative and full path: `Ctrl + Alt + C` and `Shift + Alt + C`.
- Fold all and fold all comments: `Ctrl + K + Ctrl + 0` and `Ctrl + K + Ctrl + J`.
- Unfold all and unfold all comments?


### Useful at Default or Removed

- Last edit location.
- Go to bracket.
- Create folding range from selection.
- Delete line (better to select and delete).
- Previous and next ctrl F.
- Previous and next problem.
- Previous and next change.
- Previous and next chat suggestion.
- Accept and undo chat suggestion.


### To-Do Keybindings

- View, Test, Terminal, Search editor, Debugging
- Extensions, Notebook, Inline Chat
- Go to
- View: Toggle Locked Scrolling Across Editors
- Process explorer e dev tools
