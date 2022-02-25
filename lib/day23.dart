import 'package:flutter/material.dart';

class Day23 extends StatelessWidget {
  const Day23({Key? key}) : super(key: key);
  static const String routeName = 'day23';
  static const String dayTitle = 'Day 23: Amphipod ';

  @override
  Widget build(BuildContext context) {
    final resultPart1 = doPart1();
    final resultPart2 = doPart2();
    return Scaffold(
      appBar: AppBar(
        title: const Text(dayTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            SelectableText('Svar dag 23 del 1: $resultPart1'),
            SelectableText('Svar dag 23 del 2 : $resultPart2'),
          ],
        ),
      ),
    );
  }

  int doPart1() {
    final lines = getInput(example: true);
    Board board = Board();

    return 0;
  }

  int doPart2() {
    return 0;
  }

  List<String> getInput({required bool example}) {
    String input = example ? exampleInputText : inputText;
    return input.split('\n');
  }
}

class Board {
  List<Pos> positions = List.generate(19, (index) => Pos(index));
  static const int aHomeUpper = 11;
  static const int bHomeUpper = 12;
  static const int cHomeUpper = 13;
  static const int dHomeUpper = 14;
  static const int aHomeLower = 15;
  static const int bHomeLower = 16;
  static const int cHomeLower = 17;
  static const int dHomeLower = 18;
  static List<int> hallwayPositions = List.generate(11, (index) => (index));
  static List<int> homePositions = List.generate(8, (index) => (index + 11));
  static List<int> homeUpperPositions = List.generate(4, (index) => (index + 11));
  static List<int> homeLowerPositions = List.generate(4, (index) => (index + 15));

  static Board fromInput(List<String> lines) {
    Board board = Board();
    String homeUpper = lines[2].replaceAll('#', '');
    board.positions[aHomeUpper].occupant = Amphipod.fromName(homeUpper[0]);
    board.positions[bHomeUpper].occupant = Amphipod.fromName(homeUpper[1]);
    board.positions[cHomeUpper].occupant = Amphipod.fromName(homeUpper[2]);
    board.positions[dHomeUpper].occupant = Amphipod.fromName(homeUpper[3]);
    String homeLower = lines[3].trim().replaceAll('#', '');
    board.positions[aHomeLower].occupant = Amphipod.fromName(homeLower[0]);
    board.positions[bHomeLower].occupant = Amphipod.fromName(homeLower[1]);
    board.positions[cHomeLower].occupant = Amphipod.fromName(homeLower[2]);
    board.positions[dHomeLower].occupant = Amphipod.fromName(homeLower[3]);
    for ( int pos in homeLowerPositions) {
      if ( board)
    }
    return board;
  }

  getPossibleMoves() {
    // Loop through all positions
    for (final pos in homePositions) {
      final amphiPod = positions[pos].occupant;
      if (amphiPod != null) {

        // This home has an occupant. Can it move?
        // First check if it is in its own room
        if (amphiPod.isInCorrectHome(pos)) {
          // Correct home. Does it need to move to let a lower wrong one out?
          if (isUpper(pos)) {
            int lowerPos = getPosBelow(pos);
            if ( positions[lowerPos].occupant!.isInCorrectHome(lowerPos)) {
              amphiPod.
            }
          }
        }
      }
    }
  }

  bool isUpper(int pos) {
    return homeUpperPositions.contains(pos);
  }

  int getPosBelow(int pos) {
    return pos + 4;
  }

  String getState() {
    String state = '';
    for (Pos pos in positions) {
      state += pos.getNameOfOccupant();
    }
    return state;
  }

  void print() {
    debugPrint('#############');

    // Print hallway
    String s = '#';
    for (int pos in hallwayPositions) {

      if (positions[pos].occupant != null) {
        s += positions[pos].occupant!.name;
      } else {
        s += '.';
      }
    }
    s += '#';
    debugPrint(s);

    // Print upper and lower homes
    String upper = '###';
    for (int pos in homeUpperPositions) {
      upper += positions[pos].getNameOfOccupant() + '#';
    }

    String lower = '  #';
    for (int pos in homeLowerPositions) {
      lower += positions[pos].getNameOfOccupant() + '#';
    }
    upper += '##';
    debugPrint(upper);
    debugPrint(lower);
    debugPrint('  #########');
    debugPrint(getState());
  }
}

class Pos {
  Amphipod? occupant; // Holds the occupant if this pos has one. Otherwise null
  int positionInBoard = -1; // Position in the board. 0..10 is in hallway and
  // 11 to 14 is upper level of positions and 15 to 18 is lower level

  String getNameOfOccupant() {
    if (occupant == null) {
      return '.';
    } else {
      return occupant!.name;
    }
  }

  Pos(this.positionInBoard);
}

abstract class Amphipod {
  int stepEnergy = 0;
  int home = 0;
  String name = '.';
  bool isAlreadyHome = false;
  List<int> amberHomePositions = [11,15];
  List<int> bronzeHomePositions = [12,16];
  List<int> copperHomePositions = [13,17];
  List<int> desertHomePositions = [14,18];

  static Amphipod? fromName(String name) {
    if (name == 'A') return Amber();
    if (name == 'B') return Bronze();
    if (name == 'C') return Copper();
    if (name == 'D') return Desert();
    return null;
  }

  String getName() {
    return name;
  }

  bool isInCorrectHome(int posInBoard) {

    return false;
  }
}

class Amber extends Amphipod {
  Amber() {
    stepEnergy = 1;
    home = 0;
    name = 'A';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return amberHomePositions.contains(posInBoard);
  }
}

class Bronze extends Amphipod {
  Bronze() {
    stepEnergy = 10;
    home = 1;
    home = 1;
    name = 'B';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return bronzeHomePositions.contains(posInBoard);
  }
}

class Copper extends Amphipod {
  Copper() {
    stepEnergy = 100;
    home = 2;
    name = 'C';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return copperHomePositions.contains(posInBoard);
  }
}

class Desert extends Amphipod {
  Desert() {
    stepEnergy = 1000;
    home = 3;
    name = 'D';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return desertHomePositions.contains(posInBoard);
  }
}

String exampleInputText = '''#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########''';

String inputText = '''#############
#...........#
###C#A#B#C###
  #D#D#B#A#
  #########''';
