import 'package:advent_of_code/day23.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String exampleInputText = '''#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########''';
  test('Input', () {
    Board board = Board.fromInput(exampleInputText.split('\n'));
    board.print();
    expect(board.getState(), '...........BCBDADCA');

  });

  test('Possible moves', () {
    String input = '''#############
#.B.........#
###A#.#C#D###
  #A#C#D#B#
  #########''';
    Board board = Board.fromInput(input.split('\n'));
    board.print();
    final moves = board.getPossibleMoves();
    expect(moves.length, 11);
  });
}
