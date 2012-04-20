// Generated Dart class from HTML template.
// DO NOT EDIT.

class EntityContainer {
  Map<String, Object> _scopes;
  Element _fragment;

  EntityContainer() : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_entity_container_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<table></table>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<caption>Container</caption>');
    e0.elements.add(e1);
    var e2 = new Element.html('<thead></thead>');
    e0.elements.add(e2);
    var e3 = new Element.html('<tr></tr>');
    e2.elements.add(e3);
    var e4 = new Element.html('<td>#</td>');
    e3.elements.add(e4);
    var e5 = new Element.html('<td>Symbol</td>');
    e3.elements.add(e5);
    var e6 = new Element.html('<td>Decimal Notation</td>');
    e3.elements.add(e6);
    var e7 = new Element.html('<tbody></tbody>');
    e0.elements.add(e7);
    var e8 = new Element.html('<tfoot></tfoot>');
    e0.elements.add(e8);
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
bool entity_container_stylesheet_added = false;
void add_entity_container_templatesStyles() {
  if (!entity_container_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(EntityContainer.stylesheet);

    entity_container_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
