/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

class MarqueeCanvas {
    CanvasElement canvas;
    CanvasRenderingContext2D context;
    num renderTime;
    int width = 800, height = 100;
    int xPos;
    int yPos = 80;
    String text;

    bool draw(int time) {
        renderTime = time;
        clear();
        drawOnCanvas();
        if (yPos < height) redraw();
    }

    void initMarquee() {
        canvas = new CanvasElement(width, height);
        canvas.style.cssText = 'display: block;';
        context = canvas.getContext('2d');
        context.font = '66px serif';

        document.body.elements.add(canvas);
    }

    void drawTextContainer() {
        context.strokeStyle = "#ee1";
        context.fillStyle = "#119";
        context.fillRect(0, 0, canvas.width, canvas.height);
        context.strokeRect(0, 0, canvas.width, canvas.height, 5);
    }

    void drawOnCanvas() {
        drawTextContainer();
        context.fillStyle = "#ee1";
        context.fillText(text, xPos, yPos, width);
//        context.strokeText(text, xPos, yPos, 13);

        xPos -= 1;
    }

    void redraw() {
        window.requestAnimationFrame(draw);
    }

    void clear() {
        context.clearRect(0, 0, canvas.width, canvas.height); // alternative
    }

    MarqueeCanvas(this.text) {
        xPos = width;
        initMarquee();
        redraw();
// TODO specific frame rate problem
    // TODO dynamic width/height initialization
    }

}