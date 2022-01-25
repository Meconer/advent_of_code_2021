import 'package:flutter/material.dart';


class Day12 extends StatelessWidget {
  const Day12({Key? key}) : super(key: key);
  static String routeName = 'day12';
  final bool isExample = true;
  static String dayTitle = 'Day 12: Passage Pathing';

  @override
  Widget build(BuildContext context) {
    final resultPart1 = doPart1();
    final resultPart2 = doPart2();
    return Scaffold(
      appBar: AppBar(
        title: Text(dayTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            SelectableText('Svar dag 12 del 1: $resultPart1'),
            SelectableText('Svar dag 12 del 2 : $resultPart2'),
          ],
        ),
      ),
    );
  }

  int doPart1() {
    final caves = getInput(isExample);
    caves.printConnections();
    caves.findPaths();
    return 0;
  }

  int doPart2() {
    final inputs = getInput(isExample);
    return 0;
  }

  CaveSystem getInput(bool example) {
    CaveSystem caveSystem = CaveSystem();
    late List<String> lines;
    if (example) {
      lines =  exampleInputText.split('\n');
    } else {
      lines = inputText.split('\n');
    }
    for ( String line in lines ) {
      final caveNames = line.split('-');
      caveSystem.addCaves(caveNames[0], caveNames[1]);
      caveSystem.addCaves(caveNames[1], caveNames[0]);
    }
    return caveSystem;
  }

}

class Cave {
  String name;
  Set<Cave> connections = {};

  Cave(this.name);

  bool isSmall() {
    if (name.toLowerCase() == name) return true;
    return false;
  }
}

class CaveSystem {
  Set<Cave> caveSet = {};

  void addCaves(String caveName, String connectedToCaveName) {
    final cave = getCaveIfExists(caveName) ?? Cave(caveName);
    final connectedCave = getCaveIfExists(connectedToCaveName) ?? Cave(connectedToCaveName);
    cave.connections.add(connectedCave);
    connectedCave.connections.add(cave);
    caveSet.add(cave);
    caveSet.add(connectedCave);
  }

  Cave? getCaveIfExists(String nameToCheck) {
    for (final cave in caveSet) {
      if (cave.name == nameToCheck) return cave;
    }
    return null;
  }

  void printConnections() {
    for (var cave in caveSet) {
      debugPrint('Cave ${cave.name}');
      for (var connection in cave.connections ) {
        debugPrint(' - ${connection.name}');
      }
    }
  }

  void findPaths() {
    List<List<Cave>> path = [];
    final startCave = locateCavebyName('start')!;
    for ( final cave in startCave.connections ) {
      Set<Cave> visitedCaves = {startCave};
      path.addAll(findAllPaths(cave, visitedCaves);
    }
  }

  List<List<Cave>> findAllPaths(Cave cave, Set<Cave> visitedCaves) {
    for (Cave nextCave in cave.connections) {
      if (nextCave.isSmall() && visitedCaves.contains(nextCave)) {
        return List<List<Cave>>[];
      }
    }
  }

  Cave? locateCavebyName(String nameToFind) {
    for (final node in caveSet ) {
      if (node.name == nameToFind) return node;
    }
    return null;
  }

}

String exampleInputText =
'''start-A
start-b
A-c
A-b
b-d
A-end
b-end''';

String inputText =
'''mj-TZ
start-LY
TX-ez
uw-ez
ez-TZ
TH-vn
sb-uw
uw-LY
LY-mj
sb-TX
TH-end
end-LY
mj-start
TZ-sb
uw-RR
start-TZ
mj-TH
ez-TH
sb-end
LY-ez
TX-mt
vn-sb
uw-vn
uw-TZ
''';
