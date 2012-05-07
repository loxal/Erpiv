/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('EntityLister');
#import('dart:html');
//#import('test.dart');
#source('layout.dart');
#source('entity_viewer.dart');
#source('entity_container.dart');

class EntityLister {

InputElement symbolFrom;
InputElement symbolTo;
LabelElement symbolToLabel;
DivElement app;
BaseElement base;

preinit() {
    final HeadingElement h1 = new Element.tag('h1');
    h1.innerHTML = 'Symbol Lister';
    final TitleElement title = new Element.tag('title');
    title.innerHTML = 'My Title';
    document.head.nodes.add(title);

    FieldSetElement fieldset = new Element.tag('fieldset');
    LegendElement legend = new Element.tag('legend');
    legend.innerHTML = 'Range';

    LabelElement symbolFromLabel = new Element.tag('label');
    symbolFromLabel.innerHTML = 'From:';

    symbolFrom = new Element.tag('input');
    symbolFrom.type = 'text';
    symbolFrom.value = '9985';

    symbolTo = new Element.tag('input');
    symbolTo.type = 'text';
    symbolTo.value = '10000';

    symbolToLabel= new Element.tag('label');
    symbolToLabel.innerHTML = 'To:';

    final ButtonElement refresh = new Element.tag('button');
    refresh.innerHTML = 'Refresh';
    refresh.classes.add('icon-refresh');
    refresh.on.click.add((e) => refreshSymbolList());

    fieldset.nodes.add(symbolFromLabel);
    fieldset.nodes.add(symbolFrom);
    fieldset.nodes.add(symbolToLabel);
    fieldset.nodes.add(symbolTo);
    fieldset.nodes.add(refresh);

    fieldset.nodes.add(legend);

    app.nodes.add(fieldset);

    app.nodes.add(h1);
}

TableSectionElement tbody;
initContainer() {
    final TableElement container = new Element.tag('table');
    final TableCaptionElement tableCaption = new Element.tag('caption');
    tableCaption.innerHTML = 'Container';
    container.elements.add(tableCaption);
    TableSectionElement thead = new Element.tag('thead');
    TableSectionElement tfoot = new Element.tag('tfoot');
    tbody = new Element.tag('tbody');
    TableRowElement header = new Element.tag('tr');
    TableRowElement footer = new Element.tag('tr');
    totalSymbols = new Element.tag('td');
    decimalRange = new Element.tag('td');
    footer.elements.add(totalSymbols);
    footer.elements.add(decimalRange);
    Element thNum = container.createTHead();
    thNum.innerHTML = '#';
    Element thSymbol = container.createTHead();
    thSymbol.innerHTML = 'Symbol';
    Element thNotation = container.createTHead();
    thNotation.innerHTML = 'Decimal Notation';
    header.elements.add(thNum);
    header.elements.add(thSymbol);
    header.elements.add(thNotation);
    thead.elements.add(header);
    tfoot.elements.add(footer);
    container.elements.add(thead);
    container.elements.add(tbody);
    container.elements.add(tfoot);

    app.elements.add(container);
}

TableCellElement totalSymbols;
TableCellElement decimalRange;
refreshSymbolList() {
     final int symbolFromNum = Math.parseInt(symbolFrom.value);
     final int symbolToNum = Math.parseInt(symbolTo.value);

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

    refreshSymbolList();
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
      print('constructed');
      base = new Element.tag('base');
      base.href = "/Users/alex/my/project/Erpiv/src/static/theme/icon/";
      document.head.elements.add(base);
  }
}

main() {
    final EntityLister my = new EntityLister();
    my.app =  new Element.tag('div');
    document.body.elements.add(my.app);
    my.preinit();
    my.initContainer();
    
    
    List entities = ['apples', 'oranges', 'bananas'];
    Layout l = new Layout(42, entities);
    document.body.elements.add(l.root);

    my.init();
    my.refreshSymbolList();

}

