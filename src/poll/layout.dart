// Generated Dart class from HTML template.
// DO NOT EDIT.

class Layout {
  Map<String, Object> _scopes;
  Element _fragment;

  var panel;


  // Elements bound to a variable:
  var hello;

  Layout(this.panel) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_foo_templatesStyles();

    _fragment = new DocumentFragment();
    hello = new Element.html('<div>');
    _fragment.elements.add(hello);

    // Call template Pager.
    var e0 = new Poll(panel);
    hello.elements.add(e0.root);
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
bool foo_stylesheet_added = false;
void add_foo_templatesStyles() {
  if (!foo_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Layout.stylesheet);

    foo_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
