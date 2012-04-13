// Generated Dart class from HTML template.
// DO NOT EDIT.

class pager {
  Map<String, Object> _scopes;
  Element _fragment;

  var data;

  pager(this.data) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_foo_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<div></div>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<table></table>');
    e0.elements.add(e1);
    var e2 = new Element.html('<caption>Caption</caption>');
    e1.elements.add(e2);
    var e3 = new Element.html('<thead></thead>');
    e1.elements.add(e3);
    var e4 = new Element.html('<tr></tr>');
    e3.elements.add(e4);
    var e5 = new Element.html('<th>Number</th>');
    e4.elements.add(e5);
    var e6 = new Element.html('<th>Entity</th>');
    e4.elements.add(e6);
    var e7 = new Element.html('<tbody></tbody>');
    e1.elements.add(e7);
    var e8 = new Element.html('<tr></tr>');
    e7.elements.add(e8);
    var e9 = new Element.html('<td></td>');
    e8.elements.add(e9);
    var e10 = new Element.html('<td></td>');
    e8.elements.add(e10);
    var e11 = new Element.html('<tfoot></tfoot>');
    e1.elements.add(e11);
    var e12 = new Element.html('<tr></tr>');
    e11.elements.add(e12);
    var e13 = new Element.html('<td></td>');
    e12.elements.add(e13);
    var e14 = new Element.html('<td></td>');
    e12.elements.add(e14);
    var e15 = new Element.html('<p>${inject_0()}</p>');
    e0.elements.add(e15);
  }

  Element get root() => _fragment;

  // Injection functions:
  String inject_0() {
    return safeHTML('${data}');
  }

  // Each functions:

  // With functions:

  // CSS for this template.
  static final String stylesheet = "";
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}



