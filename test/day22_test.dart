import 'package:advent_of_code/day22.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testInput = '''on x=10..12,y=10..12,z=10..12
on x=11..13,y=11..13,z=11..13
off x=9..11,y=9..11,z=9..11
on x=10..10,y=10..10,z=10..10''';

  test('Get input', () {
    final command = Command.fromInputLine(testInput.split('\n')[0]);

    expect(command.turnOn, true);
    expect(command.xMax, 12);
  });

  test('Create cubes', () {
    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    expect(cubes.cubeList.length, 4);
  });

  test('Cube calc', () {
    String testInput = '''on x=10..20,y=10..20,z=10..20
on x=15..25,y=15..25,z=15..25
off x=5..12,y=5..12,z=5..12''';

    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    expect(cubes.cubeList.length, 3);
    expect(cubes.cubeList[0].interSect(cubes.cubeList[1]), true);
    expect(cubes.cubeList[0].interSect(cubes.cubeList[2]), true);
    expect(cubes.cubeList[1].interSect(cubes.cubeList[2]), false);
  });

  test('Cube split', () {
    String testInput = '''on x=10..20,y=10..20,z=10..20
on x=15..25,y=15..25,z=15..25''';

    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      //command.print();
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    final cube1Split = cubes.split(cubes.cubeList.first, cubes.cubeList[1]);
    expect(cube1Split.length, 8);
    for ( Cube cube in cube1Split) {
      cube.print();
    }
  });

  test('Cube split and add', () {
    String testInput = '''on x=10..20,y=10..20,z=10..20
on x=15..25,y=15..25,z=15..25''';

    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      //command.print();
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    final cube1Split = cubes.split(cubes.cubeList.first, cubes.cubeList[1]);
    final cube2Split = cubes.split(cubes.cubeList[1], cubes.cubeList.first);
    expect(cube1Split.length, 8);
    for ( Cube cube in cube1Split) {
      cube.print();
    }
    expect(cube2Split.length, 8);
    for ( Cube cube in cube2Split) {
      cube.print();
    }
    final cubesAdded = cubes.addPositiveCubes(cube1Split, cube2Split);
    debugPrint('');
    for ( Cube cube in cubesAdded) {
      cube.print();
    }
  });

  test('Cube split and add containing cube', () {
    String testInput = '''on x=10..30,y=10..30,z=10..30
on x=15..25,y=15..25,z=15..25''';

    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      //command.print();
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    final cube1Split = cubes.split(cubes.cubeList.first, cubes.cubeList[1]);
    final cube2Split = cubes.split(cubes.cubeList[1], cubes.cubeList.first);
    expect(cube1Split.length, 27);
    for ( Cube cube in cube1Split) {
      cube.print();
    }
    debugPrint('+');
    expect(cube2Split.length, 1);
    for ( Cube cube in cube2Split) {
      cube.print();
    }
    final cubesAdded = cubes.addPositiveCubes(cube1Split, cube2Split);
    debugPrint('---');
    expect(cubesAdded.length, 27);
    for ( Cube cube in cubesAdded) {
      cube.print();
    }
  });

  test('Cube split and remove contained cube', () {
    String testInput = '''on x=10..30,y=10..30,z=10..30
off x=15..25,y=15..25,z=15..25''';

    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      //command.print();
      Cube cube = Cube.fromCommand(command);
      cubes.cubeList.add(cube);
    }
    final cube1Split = cubes.split(cubes.cubeList.first, cubes.cubeList[1]);
    final cube2Split = cubes.split(cubes.cubeList[1], cubes.cubeList.first);
    expect(cube1Split.length, 27);
    for ( Cube cube in cube1Split) {
      cube.print();
    }
    debugPrint('+');
    expect(cube2Split.length, 1);
    for ( Cube cube in cube2Split) {
      cube.print();
    }
    final result = cubes.removeNegativeCubes(cube1Split, cube2Split);
    debugPrint('---');
    expect(result.length, 26);
    for ( Cube cube in result) {
      cube.print();
    }
  });

  test('Handle commands', () {
    CubeSpace cubes = CubeSpace();
    for (String line in testInput.split('\n')) {
      Command command = Command.fromInputLine(line);
      cubes.handleCommand(command);
    }
    for ( Cube cube in cubes.cubeList) {
      cube.print();
    }
    int cellCount = cubes.getVolume();
    expect(cellCount, 39);
  });
}
