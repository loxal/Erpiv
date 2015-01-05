/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library loxal.uitest;
import 'dart:html';

class Test {
    Element v;

    Test() {
    }
}

void testClickEvent() {
    DivElement div = new Element.html('<div style="background-color: blue; width: 10em; height: 10em;"></div>');
    document.body.append(div);
    div.onClick.listen((MouseEvent e) {
        print(e.type);
        print(e.view);
        print(e.detail);
        print(e.screenX);
        print(e.screenY);
        print(e.clientX);
        print(e.clientY);
        print(e.button);
    });
}

MouseEvent ev;

void fireClick() {
    ev = new MouseEvent(
        "click", window, 1,
        2020, 293,
        100, 126,
        0
    );

    queryAll('*').filter((e) => e.elements.isEmpty()).forEach((element){
        element.on.click.dispatch(new MouseEvent(
            "click", window, 1,
            2020, 299,
            100, 126,
            0
        ));
    });

}

void main() {
    Test t = new Test();
    final ButtonElement start = new Element.tag('button');
    start.text = "Start";
    start.onClick.listen((e) => testClickEvent());
    document.body.append(start);

    testClickEvent();
}