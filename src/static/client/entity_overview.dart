/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:EntityOverview');
#import('dart:html');

class EntityContainer {
  Map<String, Object> _scopes;
  Element _fragment;

  List entities;

  var tbodyl;

  EntityContainer(this.entities) : _scopes = new Map<String, Object>() {
    _fragment = new DocumentFragment();
    var containerTable = new Element.html("""
        <table>
          <caption>Container</caption>
          <thead>
            <tr>
              <td>#</td>
              <td>Symbol</td>
              <td>Decimal Notation</td>
            </tr>
          </thead>
          <tbody var="tbodyl">
              <tr>
                <td>${entities}</td>
                <td></td>
                <td></td>
              </tr>
          </tbody>
          <tfoot></tfoot>
        </table>
    """);
    _fragment.elements.add(containerTable);
  }

  Element get root() => _fragment;
}


class EntityViewer {
  final Map<String, Object> _scopes;
  Element _fragment;

  int number;

  EntityViewer(this.number) : _scopes = new Map<String, Object>() {
    document.head.elements.add(new Element.html("""<style>
         .viewBox {
           padding: .1em;
           margin: 0 .1em 0 .1em;
           float: right;
           border-radius: .2em;
           border: 1px solid hsl(33, 55%, 55%);
         }
    </style>"""));

    _fragment = new DocumentFragment();

    Element viewer = new Element.html('''
        <fieldset>
            <legend id="my">Symbol Display</legend>
            <span class="viewBox" style="font-size: 1em;">&#x2724;</span>
            <span class="viewBox" style="font-size: 2em;">&#x2658;</span>
            <span class="viewBox" style="font-size: 3em;">&#x2620;</span>
            <span class="viewBox" style="font-size: 6em;">&#x2624;</span>
            <label for="symbolId">Symbol Id:</label>
            <input type="text" id="symbolId" value="x274a">&nbsp;</input>

            <p>E.g. "10046" in <em>decimal</em> notation or "<strong>x</strong>27bd" in <em>hexadecimal</em> notation</p>
            <button id="symbol-display" class="icon-list">Display Symbol</button>
        </fieldset>
    ''');
    _fragment.elements.add(viewer);
  }

  Element get root() => _fragment;
}


class Layout {
  Map<String, Object> _scopes;
  Element _fragment;

  var content;
  var entities;

  var container;

  Layout(this.entities) : _scopes = new Map<String, Object>() {
    _fragment = new DocumentFragment();
    container = new Element.html('<div>');
    _fragment.elements.add(container);

    final EntityContainer entityContainer = new EntityContainer(entities);
    container.elements.add(entityContainer.root);

    final EntityViewer entityViewer = new EntityViewer(entities);
    container.elements.add(entityViewer.root);
  }

  Element get root() => _fragment;
}

class EntityLister {

InputElement symbolFrom;
InputElement symbolTo;
LabelElement symbolToLabel;
DivElement app;
BaseElement base;

preinit() {
    final HeadingElement h1 = new Element.tag('h1');
    h1.innerHTML = 'Entity Lister';
    final TitleElement title = new Element.tag('title');
    title.innerHTML = 'My Title';
    document.head.nodes.add(title);

    Element controls = new Element.html("""
<fieldset>
<legend>Rangee</legend>
<label>From:</label>
<input type="text" value="9985" id="symbolFrom"/>
<label>To:</label>
<input type="text" value="10000" id="symbolTo"/>
<button class="icon-refresh" id="refresh" onclick="refreshSymbolList()">Refresh</button>
</fieldset>
""");
    
    app.nodes.add(controls);

    app.nodes.add(h1);
}

TableSectionElement tbody;
initContainer() {
  Element container = new Element.html("""
<table>
<caption>Container<caption>
<thead><tr><td></td><td></td></tr></thead>
<tbody id="tbody"></tbody>
<tfoot><tr><td></td><td></td></tr></tfoot>
</table>
""");
  
  tbody = document.body.query('#tbody');
  

    app.elements.add(container);
}

TableCellElement totalSymbols;
TableCellElement decimalRange;
refreshSymbolList() {
     final int symbolFromNum = Math.parseInt(document.body.query('#symbolFrom').value);
     final int symbolToNum = Math.parseInt(document.body.query('#symbolTo').value);

   tbody.nodes.clear();
   int code = 1;
   for (int idx = symbolFromNum; idx < symbolToNum; idx++) {
      final symbol = new Element.html('<tr><td>' + code++ + '</td><td>' + new String.fromCharCodes([idx])+ '</td><td>' +
       idx
      + '</td></tr>');

     tbody.elements.add(symbol);

     totalSymbols.innerHTML = (symbolToNum - symbolFromNum).toString();

     decimalRange.innerHTML = symbolFromNum.toString() + ' - ' + symbolToNum.toString();
   }
}

init() {
  document.head.nodes.add(getStylesheet());

    final ButtonElement display = document.body.query('#symbol-display');
    display.on.click.add((e) => displaySymbol());

}

getStylesheet() {
    final LinkElement styleSheet = new Element.tag("link");
    styleSheet.rel = "stylesheet";
    styleSheet.type="text/css";
    styleSheet.href="css/font-awesome.css";
    return styleSheet;
}

displaySymbol() {
    final List<Element> a = document.queryAll('.viewBox');
    final InputElement symbolId = document.query('#symbolId');
    for(final InputElement e in a) {
      e.innerHTML = '&#' + symbolId.value + ';';
    }
}

  EntityLister() {
      base = new Element.tag('base');
      base.href = "/Users/alex/my/project/Erpiv/src/static/theme/icon/";
      document.head.elements.add(base);
  }
}

main() {
    final EntityLister entityLister = new EntityLister();
    entityLister.app =  new Element.tag('div');
    document.body.elements.add(entityLister.app);
    entityLister.preinit();
    entityLister.initContainer();
    
    
    Layout layout = new Layout(['apples', 'oranges', 'bananas']);
    document.body.elements.add(layout.root);

    entityLister.init();
    entityLister.refreshSymbolList();

}

