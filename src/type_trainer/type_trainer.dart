#library('loxal:typetrainer');

#import('dart:html');
#import('dart:math');

class TypeTrainer {
    MarqueeElement marquee;
    MarqueeElement marqueeInner;

TypeTrainer(String scrollingText) {
    marqueeInner = new Element.html("""
      <marquee>
        $scrollingText
    </marquee>
    """);
    marqueeInner.behavior = 'alternate';
  marquee = new Element.html("""
      <marquee direction="left" height="20" style="border: solid;">$scrollingText</marquee>
    """);
    marquee.behavior = 'scroll';

    document.body.elements.add(marquee);
//    marquee.scrollAmount = 3;
    print(marquee.scrollAmount);
//    marquee.scrollDelay = 300;
    marquee.trueSpeed = false;
    marquee.loop = 2;
    marquee.vspace = 100;
    marquee.hspace = 100;
    marquee.width = '50%';
    print(marquee.scrollDelay);
    print(marquee.trueSpeed);
    print(marquee.loop);
    print(marquee.hspace);
    print(marquee.vspace);
//    marquee.elements.add(marqueeInner);
//    marquee.stop();
//    marqueeInner.stop();
}

}


void bindHandlers() {
                   window.on.keyPress.add((KeyboardEvent event) {
                        String keyLiteral = new String.fromCharCodes([event.charCode]);
                        typeTrainer.marquee.stop();
                        if(keyLiteral == typeTrainer.marquee.text[0]) { // replace by startsWith
                            print(keyLiteral);
                            typeTrainer.marquee.text = typeTrainer.marquee.text.substring(1);
                                               typeTrainer.marquee.scrollDelay = 400;
                        }
                        typeTrainer.marquee.start();
//                        typeTrainer.marquee.innerHTML = keyLiteral;
                    });
}

String generateText() {
    String text = '';
    Random random = new Random();
    for(var i = 1; i < 13; i++) {
        int letterCode = random.nextInt(26) + 97;
        text += new String.fromCharCodes([letterCode]);
        if(i%3 === 0) {
            text += ' ';
        }
    }

    return text;
}

TypeTrainer typeTrainer;
main() {
    bindHandlers();
    typeTrainer = new TypeTrainer(generateText());
}
