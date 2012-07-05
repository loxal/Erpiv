#library('code_gen_test');

#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('../code_gen.dart');


void main() {
//    http://www.dartlang.org/docs/library-tour/#dartio---file-and-socket-io-for-command-line-apps

    group('allows()', () {
      test('version must be greater than min', () {
          CodeGen codeGen = new CodeGen();
          codeGen.readJsonApi();
      });
    });
}