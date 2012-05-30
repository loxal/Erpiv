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
    int scrollAmount = 5;
    int scrollDelay = 1;
    DivElement container;
    boolean active = true;

    void buildControls() {
    //    https://upload.wikimedia.org/wikipedia/commons/0/04/Keyboard_layout_ru%28typewriter%29.svg
    //Dvorak: http://upload.wikimedia.org/wikipedia/en/a/a6/KB_Programmer_Dvorak.svg
    //English / Hebrew: https://upload.wikimedia.org/wikipedia/commons/e/e6/Touch_typing-he.svg
    // English: http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg
    // German: https://upload.wikimedia.org/wikipedia/commons/6/60/QWERTZ-10Finger-Layout_W.svg
        Element tenFingerLayout = new Element.html("""
        <img src="http://upload.wikimedia.org/wikipedia/commons/2/29/Touch_typing.svg" width=100%/>
        """);
        document.body.elements.add(tenFingerLayout);

        ButtonElement restartButton = new Element.html("""
            <button>Restart</button>
        """);
        restartButton.on.click.add((ClickEvent event) {
            restart();
        });
        document.body.elements.add(restartButton);
    }

    void restart() {
        active = true;
        marquee.remove();
        int totalChars = number.valueAsNumber;
        print(totalChars);
                    marquee.text = generateText(totalChars: totalChars);
                    marquee.scrollAmount = scrollAmount;
                    marquee.scrollDelay = scrollDelay;
//                    bindHandlers();
                    container.elements.add(marquee);
    }

//                                          accomponement = new AudioElement('http://upload.wikimedia.org/wikipedia/commons/6/68/10_-_Vivaldi_Winter_mvt_1_Allegro_non_molto_-_John_Harrison_violin.ogg') {
//                                          accomponement = new AudioElement('http://ia600400.us.archive.org/21/items/TheFourSeasonsWinter/USAFB_Winter.mp3') {
    TypeTrainer() : spaceChar = new String.fromCharCodes([spaceCharCode]),
                                          accomponement = new AudioElement('http://www.archive.org/download/TheFourSeasonsWinter/USAFB_Winter.ogg'),
                                           number = new InputElement('number'),
                                            container = new DivElement() {
        bindHandlers();
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

        buildControls();
//        accomponement.play();
        initWidget();
    }

    void bindHandlers() {
        keyPressHandler = (final KeyboardEvent event) {
            if(event.keyIdentifier == 'Enter') {
                restart();
            }else if(active) {
                final String char = new String.fromCharCodes([event.charCode]);
                validateChar(char);
            }
        };

        document.on.keyPress.add(keyPressHandler);
    }

    void unbindHandlers() {
        active = false;
//        document.on.keyPress.remove(keyPressHandler);
    }

    void validateChar(final String keyLiteral) {
        if(typeTrainer.marquee.text[comparableIdx] == keyLiteral) {
            marquee.bgColor = '#119';
            marquee.text = cursor + typeTrainer.marquee.text.substring(comparableIdx + 1);
            if(hasFinished()) finished();
        } else {
            showMistake();
        }
    }

    void showMistake() {
        mistakeCount++;
        marquee.bgColor = '#911';
    }

    String generateText([int totalChars = 7, int spaceCharAfter = 3]) {
        this.totalChars = totalChars;
        String text = cursor;
        final Random random = new Random();
        for(var i = 1; i < totalChars; i++) {
            int letterCode = random.nextInt(26) + 97;
            text += new String.fromCharCodes([letterCode]);
            if(i % spaceCharAfter === 0) {
                text += spaceChar;
            }
        }

        return stripLastPseudoChar(text);
    }

    // avoid space as last char
    String stripLastPseudoChar(String text) {
        if(text[text.length-1] == spaceChar) {
            text = text.substring(0, text.length-1);
        }

        return text;
    }

    boolean hasFinished() {
      return typeTrainer.marquee.text.length === 1;
    }

    void finished() {
        unbindHandlers();
        marquee.scrollAmount = 100;
        marquee.scrollDelay = 0;
        marquee.text = 'Finished!';

        calculateStats();
    }

    void calculateStats() {
        final double mistakeRate = mistakeCount / totalChars;
        print('mistakeRate: ${(mistakeRate * 100).ceil()}%');
    }

    void initWidget() {
//        document.body.elements.add(accomponement);
        document.body.elements.add(number);
        number.defaultValue = '10';
        number.on.change.add((ChangeEvent event) => restart());
    }
}

TypeTrainer typeTrainer;
main() {
    typeTrainer = new TypeTrainer();
}
