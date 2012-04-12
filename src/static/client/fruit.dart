// Generated Dart class from HTML template.
// DO NOT EDIT.


class Fruit {
  Map<String, Object> _scopes;
  Element _fragment;

  List fruits;

  Fruit(this.fruits) : _scopes = new Map<String, Object>() {
    // Insure stylesheet for template exist in the document.
    add_fruit_templatesStyles();

    _fragment = new DocumentFragment();
    var e0 = new Element.html('<ul>');
    _fragment.elements.add(e0);
    each_0(fruits, e0);
  }

  Element get root() => _fragment;

  // Injection functions:
  String inject_0() {
    // Local scoped block names.
    var fruit = _scopes["fruit"];

    return safeHTML('${fruit}');
  }

  // Each functions:
  each_0(List items, Element parent) {
    for (var fruit in items) {
      _scopes["fruit"] = fruit;
      var e0 = new Element.html('<li>I do love eating a fresh, ripe ${inject_0()}</li>');
      parent.elements.add(e0);
      _scopes.remove("fruit");
    }
  }


  // With functions:

  // CSS for this template.
  static final String stylesheet = "";
}


// Inject all templates stylesheet once into the head.
bool fruit_stylesheet_added = false;
void add_fruit_templatesStyles() {
  if (!fruit_stylesheet_added) {
    StringBuffer styles = new StringBuffer();

    // All templates stylesheet.
    styles.add(Fruit.stylesheet);

    fruit_stylesheet_added = true;
    document.head.elements.add(new Element.html('<style>${styles.toString()}</style>'));
  }
}
