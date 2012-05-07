/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

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
    EntityContainer entityContainer = new EntityContainer(entities);
    container.elements.add(entityContainer.root);

    // Call template EntityViewer.
    EntityViewer entityViewer = new EntityViewer(content);
    container.elements.add(entityViewer.root);
  }

  Element get root() => _fragment;
}
