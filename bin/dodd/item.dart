import 'dart:collection';
import 'dart:io';

import 'item_iterator.dart';

class Item<T> with IterableMixin {

  final T value;
  Item<T>? next;

  Item(this.value, this.next);

  Item<T>? printGetNext() {
    stdout.write(value);
    stdout.write(next == null ? '\n' : ', ');
    return next;
  }

  Item<T>? operator [](int n) {
    Item<T>? item = this;
    for (var i = 0; i < n; ++i) {
      item = item?.next;
    }
    return item;
  }

  @override
  Iterator<Item<T>> get iterator => ItemIterator(this);
}

R itemFold<T, A, R>(A Function(Item<T>, Item<T>, A) fSome, R Function(Item<T>, A) fLast, R Function(A) fEmpty, A accumulator, Item<T>? item) {
  if (item != null) {
    var next = item.next;
    if (next != null) {
      return itemFold(fSome, fLast, fEmpty, fSome(item, next, accumulator), next);
    }
    else {
      return fLast(item, accumulator);
    }
  }
  else {
    return fEmpty(accumulator);
  }
}

R itemFoldback<T, A, R>(A Function(Item<T>, Item<T>, A) fSome, A Function(Item<T>) fLast, A Function() fEmpty, R Function(A) generator, Item<T>? item) {
  if (item != null) {
    var next = item.next;
    if (next != null) {
      return itemFoldback(fSome, fLast, fEmpty, (A innerVal) => generator(fSome(item, next, innerVal)), next);
    }
    else {
      return generator(fLast(item));
    }
  }
  else {
    return generator(fEmpty());
  }
}
