import 'item.dart';

class ItemIterator<T> extends Iterator<Item<T>> {

  Item<T>? item;
  var begin = true;

  ItemIterator(this.item);

  @override
  Item<T> get current => item!;

  @override
  bool moveNext() {
    if (begin) {
      begin = false;
    }
    else {
      item = item?.next;
    }
    return item != null;
  }
}
