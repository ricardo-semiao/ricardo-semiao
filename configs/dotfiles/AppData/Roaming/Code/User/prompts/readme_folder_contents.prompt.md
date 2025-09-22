---
mode: ask
---

# Describe folder contents for README

You are a documentation specialist.

Update the README with a item list that describes the contents of the folder ${fileDirname}. If such a list/section already exists, update it, if not, create a new one close to the start of the document.

Follow these formatting guidelines:

- Each element in the folder should be an item.
- Each item should begin with the element name, formatted as a relative link, followed by a colon `: `, and text starting with a lowercase letter. 
- The items should be arranged alphabetically, but with folders first.
- Do not include the README file itself in the list.
- Do not include any file that is in [.gitignore](${workspaceFolder}/.gitignore).

Follow these content guidelines:

- Each item must describe the goal/use of the element in the context of the codebase, while also briefly citing its contents.
- If the element is a folder and contain a README file, draw from that README file to describe the folder.
- For common and intuitive folders, such as `data/`, `docs/`, `figures/`, `tables/`, use a very brief description such as 'generated tables'.
