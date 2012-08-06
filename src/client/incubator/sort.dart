int compare(a, b) {
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else { // equal
    return 0;
  }
}


void sort() {
  List<int> unsortedList = [8, 4, 1, 3, 9, 0, 5, 7, 2, 6];
  List<int> sortedList = const[1, 2, 3, 4, 5, 6, 7, 8, 9, 0, ];

  unsortedList.sort((a, b) => compare(a, b));
  unsortedList.forEach((e) => print(e));
}
