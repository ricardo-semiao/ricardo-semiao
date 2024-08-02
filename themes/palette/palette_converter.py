import re
import colorsys

def format_definecolor(m):
    h, s, l = (int(i) / d for i, d in zip(m.groups()[1:], [360, 100, 100]))
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return f"\\definecolor{{{m.group(1)}}}{{rgb}}{{{r}, {g}, {b}}}\n"
    #hex = f"{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"
    #return f"\\definecolor{{{m.group(1)}}}{{HTML}}{{{hex}}}\n"

with open("palette/palette.css", "r") as file_in:
    palette_raw = file_in.read()

pattern = r"--([a-z]+): hsl\(([0-9]+), ([0-9]+)%, ([0-9]+)%\);"
matches = re.finditer(pattern, palette_raw)

colors = "\\usepackage{xcolor}\n"
for match in matches:
    colors += format_definecolor(match)

with open("palette/palette.tex", "w") as file_out:
    file_out.write(colors)
