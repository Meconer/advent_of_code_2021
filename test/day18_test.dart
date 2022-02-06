
import 'package:advent_of_code/day18.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Snailfish pair', () {
    final pair = SnailfishNumber.fromString('[1,2]');
    expect(pair!.isSingleNumber, false);
    expect(pair.left!.getValue(), 1);
    expect(pair.right!.getValue(), 2);
  });

  String testString1 = '[[1,2],[[3,4],5]]';
}

