#library('sort_test');

#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('../main.dart');

final List<int> sortedList = const[0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
List<int> unsortedList = const[8, 4, 1, 3, 9, 0, 5, 7, 2, 6];

void isUnsorted(List<int> list) {
  test('assure that the unsortedList is actually unsorted',

      () {
    expect(unsortedList, unorderedEquals(sortedList));
    expect(unsortedList, isNot(orderedEquals(sortedList)));
  });
}

void main() {
  group('Algorithm',

      () {
    final Stopwatch stopwatch= new Stopwatch();

    setUp(() {
      isUnsorted(unsortedList);
      unsortedList = [8, 4, 1, 3, 9, 0, 5, 7, 2, 6];

      stopwatch.start();
    });
    tearDown(() {
      print('Time elapsed: ${stopwatch.elapsed()}');
      stopwatch.reset();

      unsortedList = const[8, 4, 1, 3, 9, 0, 5, 7, 2, 6];
    });


    expect(sortedList, unorderedEquals(unsortedList));

    test('assure unsortedList is actually unsorted',

        () {
      expect(genericSort(unsortedList), orderedEquals(sortedList));
    });

    test('genericSort fails',

        () {
      expect(unsortedList, unorderedEquals(sortedList));
      expect(unsortedList, isNot(orderedEquals(sortedList)));
    });

    test('quickSort works',

        () {
      expect(quickSort(unsortedList), orderedEquals(sortedList));
    });

    test('wikipedia Quicksort',

        () {
      expect(wikipediaQuickSort(unsortedList), orderedEquals(sortedList));
    });

//    test('wikipedia Quicksort using partitions',
//
//        () {
//      expect(wikipediaQuicksortPartitionResult(unsortedList,0,0), orderedEquals(sortedList));
//    });

    test('mergeSort works',

        () {
      expect(mergeSort(unsortedList), orderedEquals(sortedList));
    });

  });
}