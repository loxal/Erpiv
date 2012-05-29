#library('loxal:typetrainer');

#import('dart:html');

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
      <marquee direction="left" width="250" height="200" style="border:solid;">
      $scrollingText
    </marquee>
    """);
    marquee.behavior = 'alternate';

    document.body.elements.add(marquee);
    print(marquee.behavior);
    print(marquee.scrollAmount);
    print(marquee.scrollDelay);
    print(marquee.trueSpeed);
//    marquee.elements.add(marqueeInner);
//    marquee.stop();
//    marqueeInner.stop();
}

}


void bindHandlers() {
                   document.on.keyPress.add((KeyboardEvent event) {
                        String keyLiteral = new String.fromCharCodes([event.charCode]);
                      print(keyLiteral);
                      typeTrainer.marquee.innerHTML = keyLiteral;
                    });
}

List<String> generateText() {

    return "Bouncable text.";
}

TypeTrainer typeTrainer;
main() {
    bindHandlers();
    typeTrainer = new TypeTrainer(generateText());
    typeTrainer.marqueeInner.innerHTML = 'boom!';


}
