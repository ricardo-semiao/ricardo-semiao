from template_injector import build

build(
    'themes/rsquartobook/rsquartobook_template.html',
    ['themes/components.html', 'themes/rsquartobook/rsquartobook_components.html'],
    'themes/rsquartobook/template/rsquartobook_html.template'
)
