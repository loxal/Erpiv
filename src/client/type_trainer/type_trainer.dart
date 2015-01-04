/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library net.loxal.typetrainer;

import 'dart:html';
import 'dart:math';
import 'dart:core';
import '../core/core.dart';
import 'view/stats_presenter.dart';
import 'marquee_canvas.dart';

class TypeTrainer extends Core {
  AudioElement accomponement;

//    http://upload.wikimedia.org/wikipedia/commons/b/b1/11_-_Vivaldi_Winter_mvt_2_Largo_-_John_Harrison_violin.ogg
//    http://upload.wikimedia.org/wikipedia/commons/2/21/12_-_Vivaldi_Winter_mvt_3_Allegro_-_John_Harrison_violin.ogg

  static final int spaceCharCode = 32;
  static final String cursor = '|';
  final String spaceChar;
  Function keyPressHandler;
  static final comparableIdx = 1;
  int totalChars;
  int mistakeCount = 0;
  InputElement number;
  TextAreaElement customText;
  int scrollAmount = 5;
  int scrollDelay = 1;
  DivElement container;
  bool active = true;
  final Storage storage;
  final String customTextKey = 'customText';
  ButtonElement mute;
  MarqueeCanvas marqueeCanvas;
  Stats stats;

  void buildControls() {
    initFingerKeyMap();
    initCustomText();
    initNumberInput();
    initRestartButton();
    initMuteButton();
  }

  void initMuteButton() {
    mute = new ButtonElement();
    mute.style.cssText = 'font-size: 3em;';
    mute.classes = ['icon-play'];
    document.body.append(mute);

    mute.onClick.listen((Event e) {
      toggleMusic();
    });
  }

  void toggleMusic() {
    if (mute.classes.contains('icon-play')) {
      mute.classes = ['icon-stop'];
      accomponement.play();
    } else {
      mute.classes = ['icon-play'];
      accomponement.pause();
    }
  }

  void initFingerKeyMap() {
//https://upload.wikimedia.org/wikipedia/commons/0/04/Keyboard_layout_ru%28typewriter%29.svg
//Dvorak: http://upload.wikimedia.org/wikipedia/en/a/a6/KB_Programmer_Dvorak.svg
//English / Hebrew: https://upload.wikimedia.org/wikipedia/commons/e/e6/Touch_typing-he.svg
//English: http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg
//German: https://upload.wikimedia.org/wikipedia/commons/6/60/QWERTZ-10Finger-Layout_W.svg
    Element tenFingerLayout = new ImageElement(src: "http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg");
    document.body.append(tenFingerLayout);
  }

  void initRestartButton() {
    ButtonElement restartButton = new Element.html("""
                     <button class=icon-refresh>Restart</button>
                 """);
    restartButton.onClick.listen((Event event) {
      restart();
    });
    document.body.append(restartButton);
  }

  void initNumberInput() {
    DivElement localContainer = new DivElement();
    localContainer.style.cssText = 'border: solid';
    localContainer.append(number);
    document.body.append(localContainer);

    number.defaultValue = '22';
    number.onChange.listen((final Event event) => restart());
  }

  void initCustomText() {
    final DivElement localContainer = new DivElement();
    final ButtonElement restartWithCustomTextButton = new ButtonElement();
    restartWithCustomTextButton.text = 'Use this text';
    restartWithCustomTextButton.classes = ['icon-list'];
    customText = new TextAreaElement();
    customText.cols = 99;
    customText.rows = 8;
    customText.defaultValue = getCustomText();

    localContainer.style.cssText = 'border: solid;';
    restartWithCustomTextButton.style.cssText = 'display: block;';

    localContainer.append(customText);
    localContainer.append(restartWithCustomTextButton);
    document.body.append(localContainer);
    restartWithCustomTextButton.onClick.listen((final Event event) => restartWithCustomText());
  }

  String getCustomText() {
    if (!storage.containsKey(customTextKey)) {
      return 'My custom text...';
    } else {
      return storage[customTextKey];
    }
  }

  void restartMarquee() {
    marqueeCanvas.restart();
    active = true;
    totalChars = int.parse(number.value);
  }

  void restart() {
    stats.remove();
    restartMarquee();

    final String text = generateText(totalCharsLocal: totalChars);
    updateText(text);
  }

  void restartWithCustomText() {
    restartMarquee();
    storeCustomText();

    updateText('|${customText.value}');
  }

  void storeCustomText() {
    storage['customText'] = customText.value;
  }


  TypeTrainer() : spaceChar = new String.fromCharCodes([spaceCharCode]),
//        accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.mp3'),
  accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.ogg'),
  number = document.createElement('input'),
  storage = window.localStorage,
  container = new DivElement() {

    stats = new Stats.placeholder();

    initWidget();
    bindHandlers();

  }

  void bindHandlers() {
    keyPressHandler =

        (final KeyboardEvent event) {
      final int rCharCode = 18;
      final int nCharCode = 14;
      if (event.ctrlKey && event.altKey && event.charCode == rCharCode) {
        restart();
      } else if (event.ctrlKey && event.altKey && event.charCode == nCharCode) {
        number.focus();
      } else if (event.keyCode == 'Enter') {
      } else if (active) {
        final String char = new String.fromCharCodes([event.charCode]);
        validateChar(char);
      }
    };


    window.onKeyPress.listen(keyPressHandler);
  }

  void unbindHandlers() {
    active = false;
  }

  void validateChar(final String keyLiteral) {
    if (marqueeCanvas.text[comparableIdx] == keyLiteral) {
      continueAsRight();
    } else {
      showMistake();
    }
  }

  void continueAsRight() {
    marqueeCanvas.continueAsRight();
    updateText('$cursor${marqueeCanvas.text.substring(comparableIdx + 1)}');
    marqueeCanvas.goBack();
    if (hasFinished()) finished();
  }

  void updateText(String text) {
    marqueeCanvas.text = text;
  }

  void showMistake() {
    mistakeCount++;
    marqueeCanvas.showMistake();
  }

  String generateText({int totalCharsLocal: 7, int spaceCharAfter: 3}) {
    this.totalChars = totalCharsLocal;
    final StringBuffer text = new StringBuffer();
    text.write(cursor);
    final Random random = new Random();
    for (int idx = 1; idx < totalCharsLocal; idx++) {
      int letterCode = random.nextInt(26) + 97;
      text.write(new String.fromCharCodes([letterCode]));
      if (idx % spaceCharAfter == 0) {
        text.write(spaceChar);
      }
    }

    return stripLastPseudoChar(text.toString());
  }

  String stripLastPseudoChar(String text) {
    if (text[text.length - 1] == spaceChar) {
      text = text.substring(0, text.length - 1);
    }

    return text;
  }

  bool hasFinished() {
    return marqueeCanvas.text.length == 1;
  }

  void finished() {
    unbindHandlers();
    updateText('Finished!');

    showStats();
  }

  void showStats() {
    stats = new Stats(document.body, totalChars, mistakeCount);
  }

  void calculateStats() {
    final double mistakeRate = mistakeCount / totalChars;
    print('mistakeRate: ${(mistakeRate * 100).ceil()}%');
  }

  void initWidget() {
    String scrollingText = generateText();
    marqueeCanvas = new MarqueeCanvas(scrollingText);
    document.body.append(container);

    buildControls();
  }
}

TypeTrainer typeTrainer;

main() {
  typeTrainer = new TypeTrainer();
}
