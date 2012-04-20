#library('blubbbbb');
#import('dart:html');
//#import('entity_lister.dart');

class Test {
  Element v;
  Test() {
    v  = new Element.html("<strong id='fest'>yeah</strong>");
    print('Test CONSTRUCTED.');
    document.body.elements.add(v);
    
  }
}

my() {
  print(document.body.query('#my').innerHTML);
}

main() {
  Test t = new Test();
  print('boom');
  final ButtonElement refresh = new Element.tag('button');
  refresh.value = "Start";
  refresh.text = "'Start";
  document.body.elements.add(refresh);
  
// New:
  refresh.on.click.add(
    (event) => my());

  print(document.body.query('#fest'));
  
  
//  Expect.equals(document.body.query('#my').innerHTML, 'yeah');
  
}