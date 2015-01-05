/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library stats;

import 'dart:html';

class Stats {
  DivElement statsPanel;
  Element host;
  int totalChars;
  int mistakeCount;

  void show() {
    final double mistakeRate = mistakeCount / totalChars;

    final HttpRequest retrieveView = new HttpRequest();
    retrieveView.open('GET', '../view/stats.html');
    retrieveView.onLoad.listen((final Event e) {
      statsPanel = new Element.html(retrieveView.responseText);
      statsPanel.querySelector('#mistakeCount').text = mistakeCount.toStringAsFixed(0);
      statsPanel.querySelector('#totalChars').innerHtml = totalChars.toStringAsFixed(0);
      statsPanel.querySelector('#errorRate').innerHtml = '${(mistakeRate * 100).round()}';

      host.append(statsPanel);
    });
    retrieveView.send();
  }

  void remove() {
//        statsPanel.remove();
  }

  Stats(this.host, this.totalChars, this.mistakeCount) {
    show();
  }

  Stats.placeholder(){
  }
}