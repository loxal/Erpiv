int compare(a, b) {
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else { // equality
    return 0;
  }
}

List<int> genericSort(List<int> list) {
  list.sort((a, b) => compare(a, b));
  return list;
}

List<int> quickSort(List<int> list) {
  if (list.length <= 1) {
    return list;
  }

  int pivot = list[0];
  List<int> less = [];
  List<int> more = [];
  List<int> pivotList = [];

// Partition
  list.forEach((e){
    if (e.compareTo(pivot) < 0) {
      less.add(e);
    } else if (e.compareTo(pivot) > 0) {
      more.add(e);
    } else {
      pivotList.add(e);
    }
  });

// Recursively sort sublists
  less = quickSort(less);
  more = quickSort(more);

// Concatenate results
  less.addAll(pivotList);
  less.addAll(more);
  return less;
}

List<int> wikipediaQuickSort(List<int> list) {
  if (list.length <= 1) return list;

  int pivot = list[0];
  list.removeRange(0, 1);
  List<int> less = [];
  List<int> more = [];

  list.forEach((e) {
    if (e.compareTo(pivot) <= 0)
      less.add(e);
    else
      more.add(e);
  });

  List<int> result = [];
  result.addAll(wikipediaQuickSort(less));
  result.add(pivot);
  result.addAll(wikipediaQuickSort(more));
  return result;
}

void mergeLists(left, right, items) {
  var a = 0;
  var t;

  while (left.length != 0 && right.length != 0) {
    if (right[0] < left[0]) {
      t = right[0];
      right.removeRange(0, 1);
    } else {
      t = left[0];
      left.removeRange(0, 1);
    }
    items[a++] = t;
  }

  while (left.length != 0) {
    t = left[0];
    left.removeRange(0, 1);
    items[a++] = t;
  }

  while (right.length != 0) {
    t = right[0];
    right.removeRange(0, 1);
    items[a++] = t;
  }
}

void mSort(items, tmp, l) {
  if (l == 1) {
    return;
  }

  var m = (l / 2).floor().toInt();
  var tmp_l = tmp.getRange(0, m);
  var tmp_r = tmp.getRange(m, tmp.length - m);

  mSort(tmp_l, items.getRange(0, m), m);
  mSort(tmp_r, items.getRange(m, items.length - m), l - m);
  mergeLists(tmp_l, tmp_r, items);
}

List<int> mergeSort(List<int> items) {
  mSort(items, items.getRange(0, items.length), items.length);
  return items;
}

//int wikipediaQuicksortPatition(List list, int left, int right, int pivotIndex) {
//  int pivot = list[pivotIndex];
//
//  list[pivotIndex] = list[right];
//  list[right] = privot;
//
//  int storeIdx = left;
//  for (int i = left; i < right; i++) {
//    if (list[i] < pivot) {
//      int listI = list[i];
//      list[i] = list[storeIdx];
//      list[storeIdx] = listI;
//      storeIdx++;
//    }
//  }
//  int listStoreIdx = list[storeIdx];
//  list[storeIdx] = list[right];
//  list[right] = listStoreIdx;
//
//  return storeIdx;
//}
//
//List<int> wikipediaQuicksortPartitionResult(List<int> list, int left, right) {
//  if (left < right) {
//    int pivotIdx = 0;
//
//    int pivotNewIdx = wikipediaQuicksortPatition(list, left, right, pivotIdx);
//
//    wikipediaQuicksortPartitionResult(list, left, pivotNewIdx -1);
//    wikipediaQuicksortPartitionResult(list, pivotNewIdx + 1, right);
//  }
//}
