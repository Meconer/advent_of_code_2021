import 'dart:math';

import 'package:advent_of_code/day8.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  static String emptyPos = '.';
  List<String> positions = List.generate(19, (_) => emptyPos);
  static List<int> hallwayPositions = List.generate(11, (index) => (index));
  static List<int> homePositions = List.generate(8, (index) => (index + 11));
  static List<int> homeUpperPositions =
      List.generate(4, (index) => (index + 11));
  static List<int> homeLowerPositions =
      List.generate(4, (index) => (index + 15));

  static List<int> permittedHallwayPositions = [0,1,3,5,7,9,10];

  static Board fromInput(List<String> lines) {
    Board board = Board();

    String hallway = lines[1].substring(1,11);
    for (int i = 0; i < hallway.length; i++) {
      board.positions[i] = hallway[i];
    }

    String homeUpper = lines[2].replaceAll('#', '');
    String homeLower = lines[3].trim().replaceAll('#', '');
    for ( int i = 0 ; i < 4; i++) {
      board.positions[homeUpperPositions[i]] = homeUpper[i];
      board.positions[homeLowerPositions[i]] = homeLower[i];
    }
    return board;
  }

  List<MoveWithEnergy> getPossibleMoves() {
    // Loop through all positions
    List<MoveWithEnergy> possibleMoves = []; // Possible states after move

    // Check if any amphipods are in the hallway and can move into their
    // destination rooms
    for (final pos in hallwayPositions) {
      final amphiPod = positions[pos];
      if (amphiPod != emptyPos) {
        int destRoomToMoveInto = getDestinationRoomPos(pos);
        if (destRoomToMoveInto != 0) {
          // Amphipod home is available. Check if the path is blocked
          int home = getHomeRoom(amphiPod);
          int hallwayAboveHome = getHallwayAboveHomeNo(home);
          if (isFreePath(hallwayAboveHome, pos)) {
            // The move is possible. Add to the list of moves
            possibleMoves.add(getMoveToHome(pos, destRoomToMoveInto, amphiPod));
          }
        }
      }
    }

    // Check the upper home positions and find all the possible moves into the hallway
    for (int pos in homeUpperPositions) {
      if ( positions[pos] != emptyPos) {
        if (needToMove(pos)) {
          possibleMoves.addAll(getMovesIntoHallway(pos));
        }
      }
    }

    // Last, check the lower home positions and find the possible moves into hallway
    for (int pos in homeLowerPositions) {
      if ( positions[pos] != emptyPos) {
        if (needToMove(pos)) {
          possibleMoves.addAll(getMovesIntoHallway(pos));
        }
      }
    }
    return possibleMoves;
  }

  bool isUpper(int pos) {
    return homeUpperPositions.contains(pos);
  }

  int getPosBelow(int pos) {
    return pos + 4;
  }

  int getPosAbove(int pos) {
    return pos - 4;
  }



  void print() {
    debugPrint('#############');

    // Print hallway
    String s = '#';
    for (int pos in hallwayPositions) {
        s += positions[pos];
    }
    s += '#';
    debugPrint(s);

    // Print upper and lower homes
    String upper = '###';
    for (int pos in homeUpperPositions) {
      upper += positions[pos] + '#';
    }

    String lower = '  #';
    for (int pos in homeLowerPositions) {
      lower += positions[pos] + '#';
    }
    upper += '##';
    debugPrint(upper);
    debugPrint(lower);
    debugPrint('  #########');
    debugPrint(positions.join());
  }

  int getDestinationRoomPos(int pos) {
    final amphipodToMove = positions[pos];
    // Check if this amphipods home room is empty or only has amphipods of correct type
    final homeLowerPos = getLowerHome( getHomeRoom(amphipodToMove) );
    final occupantOfLowerPos = positions[homeLowerPos];
    if (occupantOfLowerPos != emptyPos) {
      if (occupantOfLowerPos != amphipodToMove) {
        // Lower pos has wrong type of amphipod. Not possible to move here
        return 0;
      }
      // If we get here the lower pos has correct type amphipod so if the upper
      // pos is empty we can move here
      final homeUpperPos = getUpperHome( getHomeRoom(amphipodToMove));
      final occupantOfUpperPos = positions[homeUpperPos];
      if (occupantOfUpperPos == emptyPos) {
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

  int getHallwayAboveHomeNo(int home) {
    return home * 2 + 2;
  }

  bool isFreePath(int pos1, int pos2) {
    int left = min(pos1, pos2);
    int right = max(pos1, pos2);
    if (right - left <= 1) return true;
    for (int p = left + 1; p < right; p++) {
      if (positions[p] != emptyPos) return false;
    }
    return true;
  }

  // Returns 0 for A, 1 for B, 2 for C and so on
  int getHomeRoom(String amphiPod) {
    int homeRoom = amphiPod.codeUnitAt(0) - 'A'.codeUnitAt(0);
    return homeRoom;
  }

  int getStepEnergy(String amphiPod) {
    switch (amphiPod) {
      case 'A' : return 1;
      case 'B' : return 10;
      case 'C' : return 100;
      case 'D' : return 1000;
    }
    return -1;
  }

  MoveWithEnergy getMoveToHome(int pos, int destRoomToMoveInto, String amphiPodToMove) {
    // Calculate energy needed for this move
    int p1 = getHallwayAboveHomeNo(getHomeRoom(amphiPodToMove));
    int hallwaySteps = (p1 - pos);
    int homeSteps = 1;
    if ( isLower(destRoomToMoveInto)) homeSteps = 2;
    int energy = (hallwaySteps + homeSteps) * getStepEnergy(amphiPodToMove);

    // Make the new state
    List<String> newPositions = List.from(positions);
    newPositions[pos] = emptyPos;
    newPositions[destRoomToMoveInto] = amphiPodToMove;
    String newState = newPositions.join();
    return MoveWithEnergy(newState, energy);
  }

  int getLowerHome(int homeRoom) {
    int lowerHome = homeRoom + 15;
    return lowerHome;
  }

  int getUpperHome(int homeRoom) {
    int upperHome = homeRoom + 11;
    return upperHome;
  }

  String getState() {
    return positions.join();
  }

  bool isLower(int room) {
    return homeLowerPositions.contains(room);
  }

  List<MoveWithEnergy> getMovesIntoHallway(int pos) {
    List<MoveWithEnergy> moves = [];

    // First check if this is lower home pos. If it is blocked we cannot move.
    if ( isLower(pos) && positions[getPosAbove(pos)] != emptyPos) return moves;
    int hallWayAboveHome = getHallwayAboveHomePos( pos );
    // Check all possible hallway positions
    for ( int hPos in permittedHallwayPositions) {
      if ( positions[hPos] == emptyPos ) {
        // This pos is empty. If the path is not blocked it is possible to move here
        if ( isFreePath(hPos, getHallwayAboveHomePos(pos))) {
          moves.add(getMoveToHallway(hPos, pos));
        }
      }
    }
    return moves;
  }

  MoveWithEnergy getMoveToHallway(int hallwayPos, int startPos) {
    // Calculate energy needed for this move
    int p1 = getHallwayAboveHomePos(startPos);
    int hallwaySteps = (p1 - hallwayPos).abs();
    int homeSteps = 1;
    if ( isLower(startPos)) homeSteps = 2;
    String amphiPodToMove = positions[startPos];
    int energy = (hallwaySteps + homeSteps) * getStepEnergy(amphiPodToMove);

    // Make the new state
    List<String> newPositions = List.from(positions);
    newPositions[startPos] = emptyPos;
    newPositions[hallwayPos] = amphiPodToMove;
    String newState = newPositions.join();
    return MoveWithEnergy(newState, energy);
  }


  // Returns the hallway position above pos. Must be in a home room
  int getHallwayAboveHomePos(int pos) {
    int posToCheck = pos;
    if ( isLower(pos)) posToCheck -= 4;
    int hallwayPos = (posToCheck - 11) * 2 + 2;
    return hallwayPos;
  }

  bool needToMove(int pos) {
    String amphiPod = positions[pos];
    if ( amphiPod != emptyPos) {
      int homeRoom = getHomeRoom(amphiPod);
      // If we are in our lower home we don't need to move
      if ( getLowerHome(homeRoom) == pos) return false;
      // If we are in our upper home and we have same kind of amphipod below we don't need to move
      if ( getUpperHome(homeRoom) == pos && positions[getLowerHome(homeRoom)] == amphiPod) return false;
    }
    return true;
  }


}

class MoveWithEnergy {
  String state;
  int energy;

  MoveWithEnergy(this.state, this.energy);
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
    homePositions = [11, 15];
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
    homePositions = [12, 16];
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
    homePositions = [13, 17];
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
    homePositions = [14, 18];
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
