#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
//#import('/Users/alex/my/src/dart/dart/lib/unittest/vm_config.dart');

void main() {
    group('foo',

        () {
        setUp(() {
            print('setUp');
        });
        tearDown(() {
            print('tearDown');
        });
        test('description...',

            () {
            print('desc');
        });
        test('this is a test',

            () {
            int x = 2 + 3;
            expect(x, equals(5));
        });
        test('this is another test',

            () {
            int x = 2 + 3;
            expect(x, equals(5));
        });

        test('calllback is executed once',

            () {
// wrap the callback of an asynchronous call with [expectAsync0] if
// the callback takes 0 arguments...
//          window.setTimeout(expectAsync0(() {
//            int x = 2 + 3;
//            expect(x, equals(5));
//          }), 0);
        });

        test('getDirectory',

            () {
            fs.root.getDirectory('nonexistent', flags:{},
            successCallback:
            expectAsync1((e) =>
            expect(false, 'Should not be reached'), count:0),
            errorCallback:
            expectAsync1((e) =>
            expect.equals(e.code, FileError.NOT_FOUND_ERR)));
        });
    });

}