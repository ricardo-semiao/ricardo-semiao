
# Setup
from template_injector import build


# Build template
build(
    'themes/rsquartobook/rsqb_template.html',
    ['themes/site_components.html', 'themes/rsquartobook/rsqb_components.html'],
    'themes/rsquartobook/assets/rsqb_html.template'
)
