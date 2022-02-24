import 'package:advent_of_code/day18.dart';
import 'package:advent_of_code/day23.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String exampleInputText = '''#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########''';
  test('Input', () {
    Board board = Board.fromInput(exampleInputText.split('\n'));
  });
}
