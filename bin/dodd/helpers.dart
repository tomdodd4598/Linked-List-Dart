import 'dart:io';

import 'item.dart';

Item<T>? insertItem<T>(Item<T>? start, T val, bool Function(T, Item<T>) insertBefore) {
  print('Creating item: $val');
  Item<T>? current = start, previous;

  while (current != null && !insertBefore(val, current)) {
    previous = current;
    current = current.next;
  }
  var item = Item<T>(val, current);

  if (previous == null) {
    start = item;
  }
  else {
    previous.next = item;
  }

  return start;
}

Item<T>? removeItem<T>(Item<T>? start, T val, bool Function(Item<T>, T) valueEquals) {
  Item<T>? current = start, previous;

  while (current != null && !valueEquals(current, val)) {
    previous = current;
    current = current.next;
  }

  if (current == null) {
    print('Item $val does not exist!');
  }
  else {
    if (previous == null) {
      start = current.next;
    }
    else {
      previous.next = current.next;
    }
    print('Removed item: $val');
  }

  return start;
}

Item<T>? removeAll<T>(Item<T>? start) {
  return null;
}

printList<T>(Item<T>? start) {
  while (start != null) {
    start = start.printGetNext();
  }
}

printIterator<T>(Item<T>? start) {
  if (start != null) {
    for (var item in start) {
      item.printGetNext();
    }
  }
}

printArray<T>(Item<T>? start) {
  if (start != null) {
    Item<T>? item = start;
    var i = 0;
    while (item != null) {
      item = start[i]?.printGetNext();
      i += 1;
    }
  }
}

printRecursive<T>(Item<T>? start) {
  if (start != null) {
    printRecursive(start.printGetNext());
  }
}

printFold<T>(Item<T>? start) {
  fSome(Item<T> current, Item<T> _, String accumulator) => '$accumulator${current.value}, ';
  fLast(Item<T> current, String accumulator) => '$accumulator${current.value}\n';
  fEmpty(String accumulator) => accumulator;
  stdout.write(itemFold(fSome, fLast, fEmpty, '', start));
}

printFoldback<T>(Item<T>? start) {
  fSome(Item<T> current, Item<T> _, String innerVal) => '${current.value}, $innerVal';
  fLast(Item<T> current) => '${current.value}\n';
  fEmpty() => '';
  stdout.write(itemFoldback(fSome, fLast, fEmpty, (x) => x, start));
}
