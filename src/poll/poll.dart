// Generated Dart class from HTML template.
// DO NOT EDIT.

class NameEntry {
  Map<String, Object> _scopes;
  Element _fragment;

  String name;
  int age;


  // Elements bound to a variable:
  var topDiv;
  var spanElem;

  NameEntry(this.name, this.age) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_foo_templatesStyles();

    _fragment = new DocumentFragment();
    topDiv = new Element.html('<div attr2="test2" attr1="test1" attr3="test3" attr="test"></div>');
    _fragment.elements.add(topDiv);
    spanElem = new Element.html('<span>${inject_0()}</span>');
    topDiv.elements.add(spanElem);
    var e0 = new Element.html('<span>-</span>');
    topDiv.elements.add(e0);
    var e1 = new Element.html('<span>${inject_1()}</span>');
    topDiv.elements.add(e1);
  }

  Element get root() => _fragment;

  // CSS class selectors for this template.
  static String get foo() => "foo";

  // Injection functions:
  String inject_0() {
    return safeHTML('${name}');
  }

  String inject_1() {
    return safeHTML('${age}');
  }

  // Each functions:

  // With functions:

  // CSS for this template.
  static final String stylesheet = '''
    
.foo {
  left: 10px;
}

  ''';

  // Stylesheet class selectors:
  String safeHTML(String html) {
    // TODO(terry): Escaping for XSS vulnerabilities TBD.
    return html;
  }
}
class Poll {
  Map<String, Object> _scopes;
  Element _fragment;

  var data;


  // Elements bound to a variable:
  var namePoll;
  var question;

  Poll(this.data) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_foo_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<h2>Create Poll</h2>');
    _fragment.elements.add(e0);
    var e1 = new Element.html('<fieldset></fieldset>');
    _fragment.elements.add(e1);
    var e2 = new Element.html('<legend>Legend</legend>');
    e1.elements.add(e2);
    namePoll = new Element.html('<input type="text">Name of the poll</input>');
    e1.elements.add(namePoll);
    question = new Element.html('<input type="text">Question</input>');
    e1.elements.add(question);
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
