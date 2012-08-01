/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

class MarqueeCanvas {
  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num renderTime;
  int width, height = 100;
  num xPos;
  int yPos = 70;
  String text;
  bool errorStatus = false;
  num steppingProgressPerFrame = 1.9;
  num goBackStepping = 20;

  bool draw(int time) {
    renderTime = time;
    clear();
    drawOnCanvas();
    if (xPos < 0) {
      xPos += steppingProgressPerFrame;
    }
    redraw();
  }

  void initMarquee() {
    canvas = new CanvasElement(width, height);
    canvas.style.cssText = 'display: block;';
    context = canvas.getContext('2d');
    context.font = '66px serif';
  }

  void restart() {
    xPos = width;
    errorStatus = false;
  }

  void drawTextContainer() {
    if (errorStatus) {
      context.fillStyle = Core.errorColor;
    } else {
      context.fillStyle = Core.standardColor;
    }
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.strokeStyle = "#ee1";
    context.strokeRect(0, 0, canvas.width, canvas.height, 5);
  }

  void showMistake() {
    errorStatus = true;
  }

  void continueAsRight() {
    errorStatus = false;
  }

  void drawOnCanvas() {
    drawTextContainer();
    context.fillStyle = "#ee1";
    context.fillText(text, xPos, yPos);

    xPos -= steppingProgressPerFrame;
  }

  void redraw() {
    window.requestAnimationFrame(draw);
    makeProgressivelySlower();
  }

  void clear() {
    context.clearRect(0, 0, canvas.width, canvas.height); // alternative
  }

  void attachHandler() {
    window.on.resize.add((Event e) {
      width = window.innerWidth;
    });
  }

  void goBack() {
    xPos += goBackStepping * steppingProgressPerFrame;
  }

  void makeProgressivelySlower() {
//        print(width / xPos);
//        print(1 - (1 * (xPos / width)));

//        steppingSpeed = 0.01;

//        e^x
  }

  MarqueeCanvas(this.text) {
    width = window.innerWidth;
    xPos = width;

    attachHandler();
    initMarquee();
    document.body.elements.add(canvas);
    redraw();

// todo make the draw function a typedef
  }

}