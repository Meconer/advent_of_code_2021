import 'package:advent_of_code/day8.dart';
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
      if ( board.positions[pos].occupant!.isInCorrectHome(pos)) {
        board.positions[pos].occupant!.isAlreadyHome = true;
      }
    }
    for ( int pos in homeUpperPositions) {
      if ( board.positions[pos].occupant!.isInCorrectHome(pos)
        && board.positions[pos+4].occupant!.isAlreadyHome) {
        board.positions[pos].occupant!.isAlreadyHome = true;
      }
    }
    return board;
  }

  getPossibleMoves() {
    // Loop through all positions
    List<String> possibleMoves = []; // Possible states after move

    // Check if any amphipods are in the hallway and can move into their
    // destination rooms
    for ( final pos in hallwayPositions) {
      final amphiPod = positions[pos].occupant;
      if ( amphiPod != null ) {
        int destRoomToMoveInto = getDestinationRoomPos(pos);
      }
    }
    for (final pos in homeLowerPositions) {
      final amphiPod = positions[pos].occupant;
      if (amphiPod != null) {
        if ( ! amphiPod.isAlreadyHome ) {
          // This home has an occupant. Can it move?

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

  int getDestinationRoomPos(int pos) {
    final amphipodToMove = positions[pos].occupant!;
    // Check if this amphipods home room is empty or only has amphipods of correct type
    final homeLowerPos = amphipodToMove.homePositions[0];
    final occupantOfLowerPos = positions[homeLowerPos].occupant;
    if ( occupantOfLowerPos != null) {
      if (occupantOfLowerPos.name != amphipodToMove.name) {
        // Lower pos has wrong type of amphipod. Not possible to move here
        return 0;
      }
      // If we get here the lower pos has correct type amphipod so if the upper
      // pos is empty we can move here
      final homeUpperPos = amphipodToMove.homePositions[1];
      final occupantOfUpperPos = positions[homeUpperPos].occupant;
      if ( occupantOfUpperPos == null ) {
        return homeUpperPos;
      } else {
        // not empty
        return 0;
      }
    } else {
      // lower pos is empty so it is possible to move here.
      return homeLowerPos;
    }
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
  late List<int> homePositions;
  String name = '.';
  bool isAlreadyHome = false;
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
    homePositions = [11,15];
    home = 0;
    name = 'A';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return homePositions.contains(posInBoard);
  }
}

class Bronze extends Amphipod {
  Bronze() {
    stepEnergy = 10;
    homePositions = [12,16];
    home = 1;
    name = 'B';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return homePositions.contains(posInBoard);
  }
}

class Copper extends Amphipod {
  Copper() {
    stepEnergy = 100;
    homePositions = [13,17];
    home = 2;
    name = 'C';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return homePositions.contains(posInBoard);
  }
}

class Desert extends Amphipod {
  Desert() {
    stepEnergy = 1000;
    homePositions = [14,18];
    home = 3;
    name = 'D';
  }

  @override
  bool isInCorrectHome(int posInBoard) {
    return homePositions.contains(posInBoard);
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
