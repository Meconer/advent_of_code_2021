import 'package:advent_of_code/day20.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testInput = '''..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###''';

  test('Get input', () {
    final trench = TrenchMap.fromInputString(testInput);
    expect(trench.enhAlgorithmString.length, 512);
    expect(trench.image.imageLines.length, 5);
    trench.image.expand();
    expect(trench.image.imageLines.length, 7);
    expect(trench.image.imageLines[0].length, 7);
    trench.image.print();
  });

  test('Decode algorithm', () {
    final trenchMap = TrenchMap.fromInputString(testInput);
    trenchMap.enhanceImage();
  });

}
