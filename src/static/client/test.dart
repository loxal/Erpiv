#library('loxal:test');
#import('dart:html');

class Test {
  Element v;
  Test() {
    v  = new Element.html("<strong id='fest'>yeah</strong>");
    document.body.elements.add(v);
    
  }
}

my() {
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
//  document.on.readyStateChange.dispatch(ev); 
//  document.body.on.load.dispatch(ev); 
//  window.on.load.dispatch(ev);
//  window.on.contentLoaded.dispatch(ev);
  
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
  final ButtonElement refresh = new Element.tag('button');
  refresh.text = "Start";
  refresh.on.click.add((e) => my());
  document.body.elements.add(refresh);
  
  testClickEvent();
  
fireClick();

//window.on.load.dispatch(ev);
//window.on.contentLoaded.dispatch(ev);

  
}