#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');

void main() {
    test('this is a test', () {
       int x = 2 + 3;
       expect(x, equals(5));
     });
    test('this is another test', () {
      int x = 2 + 3;
      expect(x, equals(5));
    });
}