import re
import os

book_pages = [
    f"docs/{file}"
    for file in os.listdir("docs/")
    if file.endswith(".html")
]

#external_links = ['"/site_assets/img/icon.png"', '"/site_assets/img/icon.png"', '"/site_assets/site_structure.css"', '"/site_assets/site_style.css"', '"/cv.html"', '"/course-rfcd/"', '"/course-ccia/"', '"/course-paaml/"', '"/mtsdesc/"', '"/phyopt/"', '"/morphdown/"', '"/site_assets/site_structure.js"']

with open("assets/rsquartobook/rsqb_html.template", "r", encoding="utf-8") as f:
    content = f.readlines()
    ext_links = [re.findall(r'"(/[^"]*)"', line) for line in content]
    ext_links = [matches[0] for matches in ext_links if matches]

for page in book_pages:
    with open(page, "r", encoding="utf-8") as f:
        new_lines = f.readlines()

        for link in ext_links:
            pat = re.escape(f'.{link}')
            new_lines = [re.sub(pat, link, line) for line in new_lines]
        
    with open(page, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
