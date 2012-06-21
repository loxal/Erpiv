/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:typetrainer');

#import('dart:html');
#import('dart:math');
#import('dart:coreimpl');
#import('../core/core.dart');
#source('MarqueeCanvas.dart');

class TypeTrainer extends Core {
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
    final Storage storage;
    final String customTextKey = 'customText';
    ButtonElement mute;
    MarqueeCanvas marqueeCanvas;

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
        document.body.elements.add(mute);

        mute.on.click.add((Event e) {
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
                     <button class=icon-refresh>Restart</button>
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
        restartWithCustomTextButton.classes = ['icon-list'];
        customText = new TextAreaElement();
        customText.cols = 99;
        customText.rows = 8;
        customText.defaultValue = getCustomText();

        localContainer.style.cssText = 'border: solid;';
        restartWithCustomTextButton.style.cssText = 'display: block;';

        localContainer.elements.add(customText);
        localContainer.elements.add(restartWithCustomTextButton);
        document.body.elements.add(localContainer);
        restartWithCustomTextButton.on.click.add((final Event event) => restartWithCustomText());
    }

    String getCustomText() {
        if (storage.$dom_getItem(customTextKey) == null) {
            return 'My custom text...';
        } else {
            return storage.$dom_getItem(customTextKey);
        }
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
        storeCustomText();

        updateText('|${customText.value}');
//        marquee.text = '|${customText.value}';
    }

    void storeCustomText() {
        storage.$dom_setItem('customText', customText.value);
    }


    TypeTrainer() : spaceChar = new String.fromCharCodes([spaceCharCode]),
//        accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.mp3'),
    accomponement = new AudioElement('http://ia700400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.ogg'),
    number = new InputElement('number'),
    storage = window.localStorage,
    container = new DivElement() {

        initWidget();
        bindHandlers();
    }

    void defineMarquee(String text) {
        String scrollingText = text;

        marquee = new Element.html("""
                <marquee style="font-size: 4em; padding: .1em; border: solid; color: yellow; height: 1.3em;">$scrollingText</marquee>
              """);
        marquee.behavior = 'slide';
        container.elements.add(marquee);
        document.body.elements.add(container);
        marquee.scrollAmount = scrollAmount;
        marquee.scrollDelay = scrollDelay;
        marquee.loop = -1;
        marquee.bgColor = Core.standardColor;
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


        window.on.keyPress.add(keyPressHandler);
    }

    void unbindHandlers() {
        active = false;
//        document.on.keyPress.remove(keyPressHandler);
    }

    void validateChar(final String keyLiteral) {
        if (typeTrainer.marquee.text[comparableIdx] == keyLiteral) {
            continueAsRight();
        } else {
            showMistake();
        }
    }

    void continueAsRight() {
        marquee.bgColor = Core.standardColor;
        marqueeCanvas.continueAsRight();
        updateText('$cursor${typeTrainer.marquee.text.substring(comparableIdx + 1)}');
        if (hasFinished()) finished();
    }

    void updateText(String text) {
        marquee.text = text;
        marqueeCanvas.text = text;
    }

    void showMistake() {
        mistakeCount++;
        marquee.bgColor = Core.errorColor;
        marqueeCanvas.showMistake();
    }

    String generateText([int totalCharsLocal = 7, int spaceCharAfter = 3]) {
        this.totalChars = totalCharsLocal;
        final StringBuffer text = new StringBuffer();
        text.add(cursor);
        final Random random = new Random();
        for (int idx = 1; idx < totalCharsLocal; idx++) {
            int letterCode = random.nextInt(26) + 97;
            text.add(new String.fromCharCodes([letterCode]));
            if (idx % spaceCharAfter === 0) {
                text.add(spaceChar);
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
        return typeTrainer.marquee.text.length === 1;
    }

    void finished() {
        unbindHandlers();
        marquee.scrollAmount = 100;
        marquee.scrollDelay = 0;
        updateText('Finished!');

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

    void initAppCache() {
        DOMApplicationCache dac = window.applicationCache;
        print(dac.status);
        dac.on.cached.add((e) => print('blub'));
        dac.on.checking.add((e) => print('blub'));
        dac.on.downloading.add((e) => print('blub'));
        dac.on.error.add((e) => print('blub'));
        dac.on.noUpdate.add((e) => print('blub'));
        dac.on.obsolete.add((e) => print('blub'));
        dac.on.progress.add((e) => print('blub'));
        dac.on.updateReady.add((e) => print('blub'));
        dac.update();
    }

    void initWidget() {
        String scrollingText = generateText();
        marqueeCanvas = new MarqueeCanvas(scrollingText);
        defineMarquee(scrollingText);

        buildControls();

//        initAppCache();
    }
}

TypeTrainer typeTrainer;

main() {
    typeTrainer = new TypeTrainer();
}
