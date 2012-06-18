/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:Core');
#import('dart:html');

class Core {
    static String basePath = '../core/theme/icon/';
    static String iconCssLocation = 'css/font-awesome.css';
    BaseElement base;

    void initBase() {
        base = new BaseElement();
        base.href = Core.basePath;
        document.head.elements.add(base);
    }

    LinkElement getCss() {
        final LinkElement css = new LinkElement();
        css.rel = 'stylesheet';
        css.type = 'text/css';
        css.href = Core.iconCssLocation;

        return css;
    }

    Core() {
        initBase();
        document.head.nodes.add(getCss());
    }
}