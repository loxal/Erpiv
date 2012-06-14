/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:typetrainer');

#import('dart:html');
#import('dart:math');
#import('dart:coreimpl');

class TypeTrainer {
    MarqueeElement marquee;
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
    DivElement statsPanel;
    bool active = true;


    void buildControls() {
        initFingerKeyMap();
        initCustomText();
        initNumberInput();
        initRestartButton();
    }

    void initFingerKeyMap() {
//    https://upload.wikimedia.org/wikipedia/commons/0/04/Keyboard_layout_ru%28typewriter%29.svg
//Dvorak: http://upload.wikimedia.org/wikipedia/en/a/a6/KB_Programmer_Dvorak.svg
//English / Hebrew: https://upload.wikimedia.org/wikipedia/commons/e/e6/Touch_typing-he.svg
// English: http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg
// German: https://upload.wikimedia.org/wikipedia/commons/6/60/QWERTZ-10Finger-Layout_W.svg
        Element tenFingerLayout = new Element.html("""
            <img src="http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg" width=100%/>
            """);
        document.body.elements.add(tenFingerLayout);
    }

    void initRestartButton() {
        ButtonElement restartButton = new Element.html("""
                     <button>Restart</button>
                 """);
        restartButton.on.click.add((Event event) {
            restart();
        });
        document.body.elements.add(restartButton);
    }

    void initNumberInput() {
        DivElement localContainer = new DivElement();
        localContainer.style.cssText = 'border: solid';
        localContainer.elements.add(number);
        document.body.elements.add(localContainer);

        number.defaultValue = '22';
        number.on.change.add((final Event event) => restart());
    }

    void initCustomText() {
        final DivElement localContainer = new DivElement();
        final ButtonElement restartWithCustomTextButton = new ButtonElement();
        restartWithCustomTextButton.text = 'Use this text';
        customText = new TextAreaElement();
        customText.cols = 99;
        customText.rows = 8;
        customText.defaultValue = 'My custom text...';

        localContainer.style.cssText = 'border: solid;';
        restartWithCustomTextButton.style.cssText = 'display: block;';

        localContainer.elements.add(customText);
        localContainer.elements.add(restartWithCustomTextButton);
        document.body.elements.add(localContainer);
        restartWithCustomTextButton.on.click.add((final Event event) => restartWithCustomText());
    }


    void restartMarquee() {
        active = true;
        marquee.remove();
        if (statsPanel != null) statsPanel.remove();
        totalChars = Math.parseInt(number.value);
        marquee.scrollAmount = scrollAmount;
        marquee.scrollDelay = scrollDelay;
        container.elements.add(marquee);
    }

    void restart() {
        restartMarquee();

        marquee.text = generateText(totalCharsLocal: totalChars);
    }

    void restartWithCustomText() {
        restartMarquee();

        marquee.text = '|${customText.value}';
    }


    TypeTrainer() : spaceChar = new String.fromCharCodes([spaceCharCode]),
//        accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.mp3'),
    accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.ogg'),
    number = new InputElement('number'),
    container = new DivElement() {

        initWidget();
        bindHandlers();
    }

    void defineMarquee() {
        String scrollingText = generateText();

        marquee = new Element.html("""
                <marquee style="font-size: 4em; padding: .1em; border: solid; color: yellow; height: 1.3em;">$scrollingText</marquee>
              """);
        marquee.behavior = 'slide';
        container.elements.add(marquee);
        document.body.elements.add(container);
        marquee.scrollAmount = scrollAmount;
        marquee.scrollDelay = scrollDelay;
        marquee.loop = -1;
        marquee.bgColor = '#119';
        marquee.width = '100%';
    }

    void bowlOver() {
        String tmp = marquee.text;
        marquee.remove();
        marquee.text = tmp;
        container.elements.add(marquee);
    }

    void bindHandlers() {
        keyPressHandler =

            (final KeyboardEvent event) {
            final int rCharCode = 18;
            final int nCharCode = 14;
            if (event.ctrlKey && event.altKey && event.charCode === rCharCode) {
                restart();
            } else if (event.ctrlKey && event.altKey && event.charCode === nCharCode) {
                number.focus();
            } else if (event.keyIdentifier == 'Enter') {
                bowlOver();
            } else if (active) {
                final String char = new String.fromCharCodes([event.charCode]);
                validateChar(char);
            }
        };


//        container.on.keyPress.add(keyPressHandler);
        window.on.keyPress.add(keyPressHandler);
//        marquee.on.keyPress.add(keyPressHandler);
//        marquee.on.keyUp.add(keyPressHandler);
    }

    void unbindHandlers() {
        active = false;
//        document.on.keyPress.remove(keyPressHandler);
    }

    void validateChar(final String keyLiteral) {
        if (typeTrainer.marquee.text[comparableIdx] == keyLiteral) {
            marquee.bgColor = '#119';
            marquee.text = '$cursor${typeTrainer.marquee.text.substring(comparableIdx + 1)}';
            if (hasFinished()) finished();
        } else {
            showMistake();
        }
    }

    void showMistake() {
        mistakeCount++;
        marquee.bgColor = '#911';
    }

    String generateText([int totalCharsLocal = 7, int spaceCharAfter = 3]) {
        this.totalChars = totalCharsLocal;
        final StringBuffer text = new StringBuffer();
        text.add(cursor);
        final Random random = new Random();
        for (int i = 1; i < totalCharsLocal; i++) {
            int letterCode = random.nextInt(26) + 97;
            text.add(new String.fromCharCodes([letterCode]));
            if (i % spaceCharAfter === 0) {
                text.add(spaceChar);
            }
        }

        return stripLastPseudoChar(text.toString());
    }

// avoid space as last char

    String stripLastPseudoChar(String text) {
        if (text[text.length - 1] == spaceChar) {
            text = text.substring(0, text.length - 1);
        }

        return text;
    }

    bool hasFinished() {
        return typeTrainer.marquee.text.length === 1;
    }

    void finished() {
        unbindHandlers();
        marquee.scrollAmount = 100;
        marquee.scrollDelay = 0;
        marquee.text = 'Finished!';

        showStats();
    }

    void showStats() {
        final double mistakeRate = mistakeCount / totalChars;
        statsPanel = new Element.html("""
            <div>
                <dl>
                    <dt>Total Characters</dt>
                    <dd>$totalChars</dd>
                    <dt>Errors</dt>
                    <dd>$mistakeCount</dd>
                </dl>
                Error rate: ${(mistakeRate * 100).round()}
            </div>
        """);

        document.body.elements.add(statsPanel);
    }

    void calculateStats() {
        final double mistakeRate = mistakeCount / totalChars;
        print('mistakeRate: ${(mistakeRate * 100).ceil()}%');
    }

    void buildMarquee() {
        int x = 600,
        y = 100;
        CanvasElement canvas = new CanvasElement(y, x);
        document.body.elements.add(canvas);
        CanvasRenderingContext2D context = canvas.getContext('2d');

        context.fillStyle = "navy";
        context.fillText("Hello World!", 30, 50, 100);
    }

    void playAudio() {
//        accomponement.play();
    }

    void initWidget() {
        defineMarquee();
        buildControls();
        playAudio();
    }
}

TypeTrainer typeTrainer;

main() {
    typeTrainer = new TypeTrainer();
}
