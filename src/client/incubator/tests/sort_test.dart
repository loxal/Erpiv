//#library('sort_test');

#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
//#import('/Users/alex/my/src/dart/dart/lib/unittest/html_config.dart');
#import('../main.dart');

void main() {
//  useHtmlConfiguration();

  List<int> unsortedList = [8, 4, 1, 3, 9, 0, 5, 7, 2, 6];
  List<int> sortedList = const[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, ];

  group('Algorithm',
      () {
//        final CodeGen codeGen = new CodeGen();

    test('sorts',
        () {
      unsortedList.sort((a, b) => compare(a, b));

      expect([1, 2, 3], equals(const[1, 2, 3, ]));
      expect(unsortedList, equals(unsortedList));
      expect(sortedList, equals(unsortedList));


//            final String jsonApiContent = codeGen.readJsonApi();

//            final int tasksApiJsonLengthV1 = 29623;
//            expect(jsonApiContent.length, equals(tasksApiJsonLengthV1));
//            expect(jsonApiContent.length, isNotNull);
//            expect(jsonApiContent.length, isNonZero);
//            expect(jsonApiContent.length, isPositive);
    });

    test('sorts using another alogirhtm',

        () {
//            codeGen.parseJsonApi(codeGen.readJsonApi());
    });
  });
}