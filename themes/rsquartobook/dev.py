from template_injector import build

build(
    'themes/rsquartobook/rsqb_template.html',
    ['themes/site_components.html', 'themes/rsquartobook/rsqb_components.html'],
    'themes/rsquartobook/assets/rsquartobook/rsqb_html.template'
)
