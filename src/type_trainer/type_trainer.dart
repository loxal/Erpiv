#library('loxal:typetrainer');

#import('dart:html');
#import('dart:math');

class TypeTrainer {
    MarqueeElement marquee;

    static final int spaceCharCode = 32;
    static final String cursor = '|';
    final String spaceChar;
    Function keyPressHandler;
    static final comparableIdx = 1;
    int totalChars;
    int mistakeCount = 0;

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

        ButtonElement restart = new Element.html("""
            <button>Restart</button>
        """);
        restart.on.click.add((ClickEvent event) { marquee.text = generateText();
        marquee.stop();
        marquee.start();
        marquee.blur();
        marquee.contentEditable = 'true';
        });
        document.body.elements.add(restart);
    }

    TypeTrainer(String scrollingText) : spaceChar = new String.fromCharCodes([spaceCharCode]) {
        bindHandlers();
        scrollingText = generateText();

        marquee = new Element.html("""
          <marquee style="font-size: 4em; border: solid; color: yellow; height: 1.3em;">$scrollingText</marquee>
        """);
        marquee.behavior = 'slide';

        document.body.elements.add(marquee);
        marquee.scrollAmount = 5;
        marquee.scrollDelay = 10;
        marquee.loop = 1;
        marquee.bgColor = '#119';
        marquee.width = '100%';

        buildControls();
    }

    void bindHandlers() {
        keyPressHandler = (final KeyboardEvent event) {
            final String char = new String.fromCharCodes([event.charCode]);
            validateChar(char);
        };

        window.on.keyPress.add(keyPressHandler);
    }

    void unbindHandlers() {
        window.on.keyPress.remove(keyPressHandler);
    }

    void validateChar(final String keyLiteral) {
        if(typeTrainer.marquee.text[comparableIdx] == keyLiteral) {
            typeTrainer.marquee.bgColor = '#119';
            typeTrainer.marquee.text = cursor + typeTrainer.marquee.text.substring(comparableIdx + 1);
            if(hasFinished()) finished();
        } else {
            showMistake();
        }
    }

    void showMistake() {
        mistakeCount++;
        typeTrainer.marquee.bgColor = '#911';
    }

    String generateText([int totalChars = 5, int spaceCharAfter = 3]) {
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
        return text;
    }

    boolean hasFinished() {
      return typeTrainer.marquee.text.length === 1;
    }

    void finished() {
        unbindHandlers();
                marquee.scrollAmount = 100;
                marquee.scrollDelay = 0;
        typeTrainer.marquee.text = 'Finished!';

        calculateStats();
    }

    void calculateStats() {
        final float mistakeRate = mistakeCount / totalChars;
        print('mistakeRate: ${mistakeRate * 100}%');
    }
}

TypeTrainer typeTrainer;
main() {
    typeTrainer = new TypeTrainer('');
}
