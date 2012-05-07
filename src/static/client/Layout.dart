class Layout {
  Map<String, Object> _scopes;
  Element _fragment;

  var content;
  var entities;

  var container;

  Layout(this.content, this.entities) : _scopes = new Map<String, Object>() {
    _fragment = new DocumentFragment();
    container = new Element.html('<div>');
    _fragment.elements.add(container);

    // Call template EntityContainer.
    var e0 = new EntityContainer(entities);
    container.elements.add(e0.root);

    // Call template EntityViewer.
    var e1 = new EntityViewer(content);
    container.elements.add(e1.root);
  }

  Element get root() => _fragment;
}
