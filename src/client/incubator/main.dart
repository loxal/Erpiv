#library('loxal:Incubator');

#import('dart:html');

void main() {

  Dynamic d =

  void myFunc() {
    print('void');
  };

//  d();

  var d1 =

  void myFunc() {
    print('another void');
  };

//  d1();

  d1;
  d;

  int lineCount;
//  assert(lineCount == null); // Variables (even numbers) are initially null.
//  assert(lineCount != null); // Variables (even numbers) are initially null.

  var sqr =

      (x) => x * x;
  print(sqr(5));

  print((

          (x) => x * x)(10));

  ImageElement image = new ImageElement();
  image.src = 'http://upload.wikimedia.org/wikipedia/commons/c/c4/Blackeyegalaxy.jpg';
  image.on.load.add((event) {
    window.console.log(image.height); // Will always print 0.
  });

}
