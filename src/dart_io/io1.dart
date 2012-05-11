#library('best');
#import('dart:io');

main() {
    var f = new File('io1.dart');
    Future existsFuture = f.exists();
//    print(existsFuture.isComplete());
    existsFuture.then((b) => print('exists: $b'));
    existsFuture.handleException((e) {
    print('blub');
        print(e);
        return true;
    });


               var u = 'test';
               var b = 'test1';
    print(    (var b) {
              return u;
          //    print('blub');
              });
}