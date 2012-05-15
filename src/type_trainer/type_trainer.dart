#library('loxal:typetrainer');

#import('dart:html');

class TypeTrainer {
TypeTrainer() {
  var test = new Element.html("""
  <marquee direction="down" width="250" height="200" behavior="alternate" style="border:solid">
  <marquee behavior="alternate">
    This text will bounce
  </marquee>
</marquee>
""");

    document.body.elements.add(test);
}

}

main() {
    new TypeTrainer();
}
