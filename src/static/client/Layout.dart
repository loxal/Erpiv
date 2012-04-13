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

    // Call template EntityViewer.
    var e0 = new EntityViewer(panel);
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
