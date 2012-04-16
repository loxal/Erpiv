// Generated Dart class from HTML template.
// DO NOT EDIT.

class Poll {
  Map<String, Object> _scopes;
  Element _fragment;

  var data;


  // Elements bound to a variable:
  var name;
  var question;
  var act;

  Poll(this.data) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_poll_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<h2>Create Poll</h2>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<fieldset></fieldset>');
    _fragment.elements.add(e1);
    var e2 = new Element.html('<legend>Legend</legend>');
    e1.elements.add(e2);
    name = new Element.html('<input type="text">Name of the poll</input>');
    e1.elements.add(name);
    question = new Element.html('<input type="text">Question</input>');
    e1.elements.add(question);
    act = new Element.html('<button>fest</button>');
    e1.elements.add(act);
    var e3 = new Element.html('<div></div>');
    _fragment.elements.add(e3);
    var e4 = new Element.html('<table></table>');
    e3.elements.add(e4);
    var e5 = new Element.html('<caption>Caption</caption>');
    e4.elements.add(e5);
    var e6 = new Element.html('<thead></thead>');
    e4.elements.add(e6);
    var e7 = new Element.html('<tr></tr>');
    e6.elements.add(e7);
    var e8 = new Element.html('<td>Number</td>');
    e7.elements.add(e8);
    var e9 = new Element.html('<td>Entity</td>');
    e7.elements.add(e9);
    var e10 = new Element.html('<tbody></tbody>');
    e4.elements.add(e10);
    var e11 = new Element.html('<tr></tr>');
    e10.elements.add(e11);
    var e12 = new Element.html('<td></td>');
    e11.elements.add(e12);
    var e13 = new Element.html('<td></td>');
    e11.elements.add(e13);
    var e14 = new Element.html('<tfoot></tfoot>');
    e4.elements.add(e14);
    var e15 = new Element.html('<tr></tr>');
    e14.elements.add(e15);
    var e16 = new Element.html('<td></td>');
    e15.elements.add(e16);
    var e17 = new Element.html('<td></td>');
    e15.elements.add(e17);
    var e18 = new Element.html('<p>${inject_0()}</p>');
    e3.elements.add(e18);
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


// Inject all templates stylesheet once into the head.
bool poll_stylesheet_added = false;
void add_poll_templatesStyles() {
  if (!poll_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Poll.stylesheet);

    poll_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
