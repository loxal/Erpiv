/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:poll');
#import('dart:html');
#source('poll.dart');
#source('layout.dart');

class Main {
}

main() {
  Poll p = new Poll(43);
  p.question = 'BLUB';
    Layout layout = new Layout('42');
    document.body.elements.add(layout.root);
//    print(layout.pager);
}

