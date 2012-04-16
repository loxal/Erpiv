/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:poll');
#import('dart:html');
#source('poll.dart');

class Main {
}

main() {
  Poll poll = new Poll('42');
  poll.question.value = 'BLUB';
  poll.name.value = 'myname';
  poll.act.value ='best';
  
  poll.act.on.click.add((e) => poll.question.value = 'BLUB!!!!');
  
  document.body.elements.add(poll.root);
}

