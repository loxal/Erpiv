#library('loxal:test');
#import('dart:html');

class Test {
  Element v;
  Test() {
  }
}

testClickEvent() {
  DivElement div = new Element.html('<div style="background-color: blue; width: 10em; height: 10em;"></div>');
  document.body.elements.add(div);
  div.on.click.add((MouseEvent e) {
    print(e.type);
    print(e.view);
    print(e.detail);
    print(e.screenX);
    print(e.screenY);
  print(e.clientX);
  print(e.clientY);
  print(e.button);
  });
}

MouseEvent ev;
fireClick() {
  ev = new MouseEvent(
    "click", window, 1, 
    2020, 293,
    100, 126,
    0
    ); 

  document.body.queryAll('*').filter((e) => e.elements.isEmpty()).forEach((element){
    element.on.click.dispatch(new MouseEvent(
      "click", window, 1, 
      2020, 299,
      100, 126,
      0
      ));
  });
    
}

main() {
  Test t = new Test();
  final ButtonElement start = new Element.tag('button');
  start.text = "Start";
  start.on.click.add((e) => testClickEvent());
  document.body.elements.add(start);
  
  testClickEvent();
  
    fireClick();
}