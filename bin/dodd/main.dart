import 'dart:io';

import 'helpers.dart';
import 'item.dart';

final RegExp validRegex = RegExp(r'^(0|-?[1-9][0-9]*|[A-Za-z][0-9A-Z_a-z]*)$');
final RegExp numberRegex = RegExp(r'^-?[0-9]+$');

bool isValidString(String str) {
  return validRegex.hasMatch(str);
}

bool isNumberString(String str) {
  return numberRegex.hasMatch(str);
}

bool insertBefore(String val, Item<String> item) {
  if (isNumberString(val) && isNumberString(item.value)) {
    return BigInt.parse(val) <= BigInt.parse(item.value);
  }
  else {
    return val.compareTo(item.value) < 1;
  }
}

bool valueEquals(Item<String> item, String val) {
  return item.value == val;
}

main() {
  Item<String>? start;

  var begin = true;

  while (true) {
    if (!begin) {
      print('');
    }
    else {
      begin = false;
    }

    print('Awaiting input...');
    final read = stdin.readLineSync();
    if (read == null) {
      print('Failed to read line!\n');
    }
    var input = read!;

    if (input.isEmpty) {
      print('\nProgram terminated!');
      start = removeAll(start);
      return;
    }
    else if (input[0] == '~') {
      if (input.length == 1) {
        print('\nDeleting list...');
        start = removeAll(start);
      }
      else {
        input = input.substring(1);
        if (isValidString(input)) {
          print('\nRemoving item...');
          start = removeItem(start, input, valueEquals);
        }
        else {
          print('\nCould not parse input!');
        }
      }
    }
    else if (input == 'l') {
      print('\nLoop print...');
      printLoop(start);
    }
    else if (input == 'i') {
      print('\nIterator print...');
      printIterator(start);
    }
    else if (input == 'a') {
      print('\nArray print...');
      printArray(start);
    }
    else if (input == 'r') {
      print('\nRecursive print...');
      printRecursive(start);
    }
    else if (input == 'f') {
      print('\nFold print...');
      printFold(start);
    }
    else if (input == 'b') {
      print('\nFoldback print...');
      printFoldback(start);
    }
    else if (isValidString(input)) {
      print('\nInserting item...');
      start = insertItem(start, input, insertBefore);
    }
    else {
      print('\nCould not parse input!');
    }
  }
}
