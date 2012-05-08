/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:EntityOverview');
#import('dart:html');

class EntityContainer {
  
  InputElement symbolFrom;
  InputElement symbolTo;
  LabelElement symbolToLabel;

  TableSectionElement tbody;
  TableCellElement totalSymbols;
  TableCellElement decimalRange;
  
  void preinit() {
      final HeadingElement h1 = new Element.tag('h1');
      h1.innerHTML = 'Entity Overview';
      final TitleElement title = new Element.tag('title');
      title.innerHTML = 'Entity Overview';
      document.head.nodes.add(title);

      Element controls = new Element.html("""
  <fieldset>
    <legend>Range</legend>
    <label>From:</label>
    <input type="text" value="9985" id="symbolFrom"/>
    <label>To:</label>
    <input type="text" value="10000" id="symbolTo"/>
    <button class="icon-refresh" id="refresh">Refresh</button>
  </fieldset>
  """);
      
      _fragment.elements.add(controls);

      _fragment.elements.add(h1);
  }
  
  void refreshSymbolList() {
    final InputElement symFrom = document.body.query('#symbolFrom');
    final InputElement symTo = document.body.query('#symbolTo');
    
       final int symbolFromNum = Math.parseInt(symFrom.value);
       final int symbolToNum = Math.parseInt(symTo.value);

       tbody = document.body.query('#tbody');
     tbody.nodes.clear();
     int code = 1;
     for (int idx = symbolFromNum; idx < symbolToNum; idx++) {
        final symbol = new Element.html('<tr><td>' + code++ + '</td><td>' + new String.fromCharCodes([idx])+ '</td><td>' +
         idx
        + '</td></tr>');

       tbody.elements.add(symbol);

       totalSymbols = document.body.query('#totalSymbols');
       totalSymbols.innerHTML = (symbolToNum - symbolFromNum).toString();

       decimalRange = document.body.query('#decimalRange');
       decimalRange.innerHTML = symbolFromNum.toString() + ' - ' + symbolToNum.toString();
     }
  }
  
  Map<String, Object> _scopes;
  Element _fragment;

  final List entities;

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
          <tbody id="tbody">
              <tr>
                <td>${entities}</td>
                <td></td>
                <td></td>
              </tr>
          </tbody>
          <tfoot>
            <tr><td id="totalSymbols"></td><td id="decimalRange"></td></tr>
          </tfoot>
        </table>
    """);
    preinit();
    
    _fragment.elements.add(containerTable);
    
    
  }

  void addUiHandler() {
    final ButtonElement refresh = document.body.query('#refresh');
    refresh.on.click.add((e) => refreshSymbolList());
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
  
  void addUiHandler() {
    final ButtonElement display = document.body.query('#symbol-display');
    display.on.click.add((e) => displaySymbol());
  }
  
  void displaySymbol() {
    final List<Element> a = document.queryAll('.viewBox');
    final InputElement symbolId = document.query('#symbolId');
    for(final InputElement e in a) {
      e.innerHTML = '&#' + symbolId.value + ';';
    }
}

  Element get root() => _fragment;
}


class Layout {
  LinkElement getCss() {
    final LinkElement css = new Element.tag("link");
    css.rel = "stylesheet";
    css.type="text/css";
    css.href="css/font-awesome.css";
    
    return css;
}
  
  void declareBase() {
    base = new Element.tag('base');
    base.href = "/Users/alex/my/project/Erpiv/src/static/theme/icon/";
    document.head.elements.add(base);
  }
  
  void init() {
    declareBase();
    
    document.head.nodes.add(getCss());
  }

  BaseElement base;
  Map<String, Object> _scopes;
  Element _fragment;

  var content;
  var entities;

  var container;

  Layout(this.entities) : _scopes = new Map<String, Object>() {
    init();
    
    
    _fragment = new DocumentFragment();
    container = new Element.html('<div>');
    _fragment.elements.add(container);

    final EntityContainer entityContainer = new EntityContainer(entities);
    container.elements.add(entityContainer.root);

    final EntityViewer entityViewer = new EntityViewer(entities);
    container.elements.add(entityViewer.root);
    document.body.elements.add(_fragment);
    
    entityContainer.addUiHandler();
    entityContainer.refreshSymbolList();
    entityViewer.addUiHandler();    
    
  }

  Element get root() => _fragment;
}

class EntityOverview {

//InputElement symbolFrom;
//InputElement symbolTo;
//LabelElement symbolToLabel;
//
//TableSectionElement tbody;
//TableCellElement totalSymbols;
//TableCellElement decimalRange;

//void refreshSymbolList() {
//  final InputElement symFrom = document.body.query('#symbolFrom');
//  final InputElement symTo = document.body.query('#symbolTo');
//  
//     final int symbolFromNum = Math.parseInt(symFrom.value);
//     final int symbolToNum = Math.parseInt(symTo.value);
//
//     tbody = document.body.query('#tbody');
//   tbody.nodes.clear();
//   int code = 1;
//   for (int idx = symbolFromNum; idx < symbolToNum; idx++) {
//      final symbol = new Element.html('<tr><td>' + code++ + '</td><td>' + new String.fromCharCodes([idx])+ '</td><td>' +
//       idx
//      + '</td></tr>');
//
//     tbody.elements.add(symbol);
//
//     totalSymbols = document.body.query('#totalSymbols');
//     totalSymbols.innerHTML = (symbolToNum - symbolFromNum).toString();
//
//     decimalRange = document.body.query('#decimalRange');
//     decimalRange.innerHTML = symbolFromNum.toString() + ' - ' + symbolToNum.toString();
//   }
//}

//void init() {
//    final ButtonElement display = document.body.query('#symbol-display');
//    display.on.click.add((e) => displaySymbol());
//    
//    final ButtonElement refresh = document.body.query('#refresh');
//    refresh.on.click.add((e) => refreshSymbolList());    
//}

//void displaySymbol() {
//    final List<Element> a = document.queryAll('.viewBox');
//    final InputElement symbolId = document.query('#symbolId');
//    for(final InputElement e in a) {
//      e.innerHTML = '&#' + symbolId.value + ';';
//    }
//}

  EntityOverview() {
//      init();
//      refreshSymbolList();
  }
}

void main() {
  final Layout layout = new Layout(null);
  
    
  new EntityOverview();
}
