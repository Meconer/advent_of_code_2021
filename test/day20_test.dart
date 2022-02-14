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
    final input = TrenchMap.fromInputString(testInput);
    expect(input.enhAlgorithmString.length, 512);
    expect(input.image.imageLines.length, 5);
    input.image.expand();
    expect(input.image.imageLines.length, 7);
    expect(input.image.imageLines[0].length, 7);
    input.image.print();
  });

  test('Decode algorithm', () {
    final input = TrenchMap.fromInputString(testInput);

  });

}
