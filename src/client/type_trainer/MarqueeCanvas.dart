/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

class MarqueeCanvas {
    CanvasElement canvas;
    CanvasRenderingContext2D context;

    void animate([int frame]) {
//        context.beginPath();
//        context.fill();
//        context.stroke();
//        context.clearRect(0, 0, canvas.width, canvas.height);


// update

// clear

// draw
        context.strokeStyle = "#ee1";
        context.fillStyle = "orange";
        context.strokeRect(0, 0, canvas.width, canvas.height, 5);
//        context.fillText("Hello World!", 10 * frame, 5 * frame);
        context.fillText("Hello World!", 10, 5);
//        context.clearRect(0, 0, canvas.width, canvas.height);

// request new frame

    }

    void initMarquee() {
        int x = 800, y = 100;
        canvas = new CanvasElement(x, y);
        canvas.style.cssText = 'display: block;';
        context = canvas.getContext('2d');
        document.body.elements.add(canvas);
    }

    MarqueeCanvas() {
        initMarquee();
        animate(1);
    }

}