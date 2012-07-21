#library('code_gen_test');

#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('../dart-google-apis/code_gen.dart');

void main() {
//    http://www.dartlang.org/docs/library-tour/#dartio---file-and-socket-io-for-command-line-apps
    group('Tasks API',

        () {
        final CodeGen codeGen = new CodeGen();

        test('assuring Tasks API JSON file contains data',

            () {
            final String jsonApiContent = codeGen.readJsonApi();

            final int tasksApiJsonLengthV1 = 29623;
            expect(jsonApiContent.length, equals(tasksApiJsonLengthV1));
            expect(jsonApiContent.length, isNotNull);
            expect(jsonApiContent.length, isNonZero);
            expect(jsonApiContent.length, isPositive);
        });

        test('parse JSON API',

            () {
            codeGen.parseJsonApi(codeGen.readJsonApi());
        });
    });
}