/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:pager');
#import('dart:html');
#source('layout.dart');
#source('pager.dart');

class EntityLister {

}

main() {
    Layout layout = new Layout(42);
    document.body.elements.add(layout.root);
}

