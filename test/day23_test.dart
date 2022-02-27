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

    for ( final home in Board.homePositions) {
      debugPrint( 'Is home : ${board.positions[home].occupant!.isInCorrectHome(home)}');
    }
    for ( final home in Board.homePositions) {
      debugPrint( 'Home flag set : ${board.positions[home].occupant!.isAlreadyHome}');
    }
  });
}
