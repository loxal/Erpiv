/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library Core;
import 'dart:html';

class Core {
    static final String errorColor = '#911';
    static final String standardColor = '#119';

    static String basePath = '../core/';
    static String iconCssLocation = 'theme/icon/css/font-awesome.css';
    BaseElement base;

    void initBase() {
        base = new BaseElement();
        base.href = basePath;
        document.head.append(base);
    }

    LinkElement getCss() {
        final LinkElement css = new LinkElement();
        css.rel = 'stylesheet';
        css.type = 'text/css';
        css.href = iconCssLocation;

        return css;
    }

    Core() {
        initBase();
        document.head.nodes.add(getCss());
    }
}