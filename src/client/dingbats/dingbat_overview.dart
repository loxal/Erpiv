/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library net.loxal.DingbatOverview;
import 'dart:html';
import '../core/core.dart';
import '../core/view.dart';

class DingbatContainer extends Core implements View {
  InputElement symFrom;
  InputElement symTo;
  LabelElement symbolToLabel;

  TableSectionElement tbody;
  TableCellElement totalSymbols;
  TableCellElement decimalRange;

  attachShortcuts() {

  }

  void initElements() {

  }

  void refreshSymbolList() {
    symFrom = querySelector('#symbolFrom');
    symTo = querySelector('#symbolTo');

    final int symbolFromNum = int.parse(symFrom.value);
    final int symbolToNum = int.parse(symTo.value);

    tbody = document.body.querySelector('#tbody');
    tbody.nodes.clear();
    int code = 1;
    for (int idx = symbolFromNum; idx < symbolToNum; idx++) {
      final symbol = new DocumentFragment();
      symbol.innerHtml =
      '''
              <tr><td>${code++}</td><td>${new String.fromCharCodes([idx])}</td><td>
              $idx
              </td></tr>''';

      tbody.append(symbol);

      totalSymbols = document.body.querySelector('#totalSymbols');
      totalSymbols.innerHtml = (symbolToNum - symbolFromNum).toString();

      decimalRange = document.body.querySelector('#decimalRange');
      decimalRange.innerHtml = '${symbolFromNum.toString()} - ${symbolToNum.toString()}';
    }
  }

  void createControlPanel() {
    final HeadingElement h1 = new Element.tag('h1');
    h1.innerHtml = 'Dingbats';
    final TitleElement title = new TitleElement();
    title.text = 'Entity Overview';
    document.head.nodes.add(title);

    Element controls = new Element.html("""
            <fieldset style="width: 22em;">
              <legend>Range</legend>
              <label>From:</label>
              <input type=text value=9985 id="symbolFrom"/>
              <label>To:</label>
              <input type=text value=9999 id="symbolTo"/>
              <select id=entityRangeSelector>
                <option value=arrow>Arrows</option>
                 <option value=star>Stars</option>
                 <option value=other>Other</option>
              </select>
              <button class=icon-refresh id=refresh>Refresh</button>
            </fieldset>
        """);

    entityOverviewContainer.append(h1);
    entityOverviewContainer.append(controls);
  }

  Map<String, List<int>> rangeMap;


  Map<String, Object> _scopes;
  DocumentFragment _fragment;

  final List entities;
  DivElement entityOverviewContainer;


  DingbatContainer(this.entities) : _scopes = new Map<String, Object>() {
    rangeMap = {
        "arrow" : [8582, 8705],
        "equality" : [8764, 9193],
        "corners" : [9472, 9908],
        "other" : [9000, 10000],
        "star" : [9900, 9985],
        "ascii": [33, 128],
    };

    _fragment = new DocumentFragment();
    entityOverviewContainer = new Element.html('<div style="-webkit-column-count: 2; -webkit-column-rule: 5px solid red; -webkit-column-gap: 1em;">');

    Element containerTable = new Element.html("""
            <div>
                <table>
                  <caption>Overview</caption>
                  <thead>
                    <tr>
                      <td>#</td>
                      <td>Dingbat</td>
                      <td>Code</td>
                    </tr>
                  </thead>
                  <tbody id='tbody'>
                  </tbody>
                  <tfoot>
                    <tr><td id='totalSymbols'></td><td id='decimalRange'></td></tr>
                  </tfoot>
                </table>
            </div>
        """);

    createControlPanel();

    entityOverviewContainer.append(containerTable);
    _fragment.append(entityOverviewContainer);

    void initWidget() {
      final SelectElement entityRangeSelector = querySelector('#entityRangeSelector');
      entityRangeSelector.onChange.listen((e) {
        final String rangeKey = entityRangeSelector.item(entityRangeSelector.selectedIndex).value;
        symFrom.value = rangeMap[rangeKey][0].toString();
        symTo.value = rangeMap[rangeKey][1].toString();
        refreshSymbolList();
      });

      final ButtonElement refresh = document.body.querySelector('#refresh');
      refresh.onClick.listen((e) => refreshSymbolList());
    }

    document.onReadyStateChange.listen((i) => initWidget());
  }

  Element get root => _fragment;
}


class EntityViewer {
  final Map<String, Object> _scopes;
  Element _fragment;

  int number;

  EntityViewer(this.number) : _scopes = new Map<String, Object>() {
    final StyleElement styleElement = new StyleElement();
    styleElement.text =
    """
     .viewBox {
       padding: .1em;
       margin: 0 .1em 0 .1em;
       float: right;
       border-radius: .2em;
       border: 1px solid hsl(33, 55%, 55%);
     }
    """;
    document.head.append(styleElement);
//        document.head.append(new Element.html("""
//        <style>
//             .viewBox {
//               padding: .1em;
//               margin: 0 .1em 0 .1em;
//               float: right;
//               border-radius: .2em;
//               border: 1px solid hsl(33, 55%, 55%);
//             }
//        </style>
//        """));

    _fragment = new DocumentFragment();

    Element viewer = new Element.html('''
        <fieldset style='width: 30em;'>
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
    _fragment.append(viewer);


    void initWidget() {
      final ButtonElement display = querySelector('#symbol-display');
      display.onClick.listen((e) => displaySymbol());
    }

    document.onReadyStateChange.listen((e) => initWidget());
  }


  void displaySymbol() {
    final List<Node> nodes = document.queryAll('.viewBox');
    final InputElement symbolId = document.querySelector('#symbolId');
    for (final Element e in nodes) {
      e.innerHtml = '&#${symbolId.value};';
    }
  }

  Element get root => _fragment;
}


class Layout {
  Map<String, Object> _scopes;
  DocumentFragment _fragment;

  var content;
  var entities;

  Layout() : _scopes = new Map<String, Object>() {
    _fragment = new DocumentFragment();

    final DingbatContainer entityContainer = new DingbatContainer(entities);
    _fragment.append(entityContainer.root);

    final EntityViewer entityViewer = new EntityViewer(entities);
    _fragment.append(entityViewer.root);

    document.body.nodes.add(_fragment);

    entityContainer.refreshSymbolList();
  }

  DocumentFragment get root => _fragment;
}

class EntityOverview {
}

void main() {
  final Layout layout = new Layout();
  new EntityOverview();
}

