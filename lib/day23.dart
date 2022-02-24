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
  List<Pos> hallway = List.filled(11, Pos());
  List<List<Pos>> homes = List.filled(4, List.filled(2, Pos()));

  static Board fromInput(List<String> lines) {
    Board board = Board();
    String homeUpper = lines[2].replaceAll('#', '');
    board.homes[0][0].occupant = Amphipod.fromChar(homeUpper[0]);
    board.homes[1][0].occupant = Amphipod.fromChar(homeUpper[1]);
    board.homes[2][0].occupant = Amphipod.fromChar(homeUpper[2]);
    board.homes[3][0].occupant = Amphipod.fromChar(homeUpper[3]);
    String homeLower = lines[2].replaceAll('#', '');
    board.homes[0][1].occupant = Amphipod.fromChar(homeLower[0]);
    board.homes[1][1].occupant = Amphipod.fromChar(homeLower[1]);
    board.homes[2][1].occupant = Amphipod.fromChar(homeLower[2]);
    board.homes[3][1].occupant = Amphipod.fromChar(homeLower[3]);
    return board;
  }

  void print() {
    debugPrint('#############');

    // Print hallway
    String s = '#';
    for ( Pos pos in hallway) {
      if ( pos.occupant != null ) {
        s += pos.occupant!.name.substring(0,1);
      } else {
        s += '.';
      }
    }
    s += '#';
    debugPrint(s);

    // Print upper and lower homes
    String upper = '###';
    String lower = '  #';
    for ( int i = 0 ; i < 4 ; i++ ) {
      Amphipod? amphipod = homes[i][0].occupant;
      upper += Amphipod.getName(amphipod) + '#';
      amphipod = homes[i][1].occupant;
      lower += Amphipod.getName(amphipod) + '#';
    }
    upper += '##';
    debugPrint(upper);
    debugPrint(lower);
    debugPrint('  #########');
  }
}

class Pos {
  Amphipod? occupant;
}

class Amphipod {
  int stepEnergy = 0;
  int home = 0;
  String name = '';

  static Amphipod? fromChar(String char) {
    if ( char == 'A') return Amber();
    if ( char == 'B') return Bronze();
    if ( char == 'C') return Copper();
    if ( char == 'D') return Desert();
    return null;
  }

  static String getName(Amphipod? amphipod) {
    if ( amphipod == null ) return '.';
    return amphipod.name.substring(0,1);
  }
}

class Amber extends Amphipod {
  Amber() {
    stepEnergy = 1;
    home = 0;
    name = 'Amber';
  }
}

class Bronze extends Amphipod {
  Bronze() {
    stepEnergy = 10;
    home = 1;
    home = 1;
    name = 'Bronze';
  }
}

class Copper extends Amphipod {
  Copper() {
    stepEnergy = 100;
    home = 2;
    name = 'Copper';
  }
}

class Desert extends Amphipod {
  Desert() {
    stepEnergy = 1000;
    home = 3;
    name = 'Desert';
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
