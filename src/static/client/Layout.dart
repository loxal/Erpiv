// Generated Dart class from HTML template.
// DO NOT EDIT.

class Layout {
  Map<String, Object> _scopes;
  Element _fragment;

  var panel;


  // Elements bound to a variable:
  var container;

  Layout(this.panel) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_layout_templatesStyles();

    _fragment = new DocumentFragment();
    container = new Element.html('<div>');
    _fragment.elements.add(container);

    // Call template EntityContainer.
    var e0 = new EntityContainer();
    container.elements.add(e0.root);

    // Call template EntityViewer.
    var e1 = new EntityViewer(panel);
    container.elements.add(e1.root);
  }

  Element get root() => _fragment;

  // Injection functions:
  // Each functions:

  // With functions:

  // CSS for this template.
  static final String stylesheet = "";
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}


// Inject all templates stylesheet once into the head.
bool layout_stylesheet_added = false;
void add_layout_templatesStyles() {
  if (!layout_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Layout.stylesheet);

    layout_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
