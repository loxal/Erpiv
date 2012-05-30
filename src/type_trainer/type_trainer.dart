#library('loxal:typetrainer');

#import('dart:html');
#import('dart:math');

class TypeTrainer {
    MarqueeElement marquee;

    static final int spaceCharCode = 32;
    static final String cursor = '|';
    final String spaceChar;

TypeTrainer(String scrollingText) : spaceChar = new String.fromCharCodes([spaceCharCode]) {
    bindHandlers();
    scrollingText = generateText();

    marquee = new Element.html("""
      <marquee style="font-size: 4em; border: solid; color: yellow; height: 1.3em;">$scrollingText</marquee>
    """);
    marquee.behavior = 'slide';

    document.body.elements.add(marquee);
    marquee.scrollAmount = 5;
    print(marquee.scrollAmount);
    marquee.scrollDelay = 10;
//    marquee.trueSpeed = false;
//    marquee.loop = 2;
    marquee.bgColor = 'blue';
    marquee.vspace = 0;
    marquee.hspace = 0;
    marquee.width = '100%';
    print(marquee.scrollDelay);
    print(marquee.trueSpeed);
    print(marquee.loop);
}

    void bindHandlers() {
        window.on.keyPress.add((final KeyboardEvent event) {
            final String keyLiteral = new String.fromCharCodes([event.charCode]);
            validateLetter(keyLiteral);
        });
    }

    void validateLetter(final String keyLiteral) {
        if(typeTrainer.marquee.text[1] == keyLiteral) {
            typeTrainer.marquee.text = '|' + typeTrainer.marquee.text.substring(2);
        }
    }

    String generateText([int numOfLetters = 13, int spaceCharAfter = 3]) {
        String text = cursor;
        final Random random = new Random();
        for(var i = 1; i < numOfLetters; i++) {
            int letterCode = random.nextInt(26) + 97;
            text += new String.fromCharCodes([letterCode]);
            if(i % spaceCharAfter === 0) {
                text += spaceChar;
            }
        }

        return text;
    }
}

TypeTrainer typeTrainer;
main() {
    typeTrainer = new TypeTrainer('');
}
