import 'package:flutter/material.dart';

class Day18 extends StatelessWidget {
  const Day18({Key? key}) : super(key: key);
  static const String routeName = 'day18';
  final bool isExample = false;
  static const String dayTitle = 'Day 18: Snailfish';

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
            SelectableText('Svar dag 18 del 1: $resultPart1'),
            SelectableText('Svar dag 18 del 2 : $resultPart2'),
          ],
        ),
      ),
    );
  }

  int doPart1() {

    return 0;
  }

  int doPart2() {
    return 0;
  }

  String getInput(bool example) {
    return  isExample ? exampleInputText : inputText;
  }
}

class SnailfishNumber {
  bool isSingleNumber;
  int? number;
  SnailfishNumber? left, right;

  SnailfishNumber({required this.isSingleNumber, this.number, this.left, this.right});

  static SnailfishNumber? fromString(String s) {
    String nextItem = s[0];
    int itemLength = 1;
    if ( isDigit(nextItem)) {
      if ( isDigit(s[1])) {
        nextItem += s[1];
        itemLength++;
      }
      return SnailfishNumber(isSingleNumber: true, number:  int.parse(nextItem));
    }

    SnailfishNumber thisNumber = SnailfishNumber(isSingleNumber: false);
    if ( nextItem == '[' ) thisNumber.left =  SnailfishNumber.fromString(s.substring(1))!;
    if ( nextItem == ',' ) thisNumber.right = SnailfishNumber.fromString(s.substring(1))!;

    if ( nextItem == ']')  return thisNumber;

    return null;
  }

  static bool isDigit(String char) {
    final digitRegex = RegExp(r'\d');
    if ( digitRegex.hasMatch(char)) {
      return true;
    }
    return false;
  }

  SnailfishNumber getLeft() {
    if ( isSingleNumber ) {
      return SnailfishNumber(isSingleNumber: true, number: number);
    } else {
      return left!;
    }
  }

  int? getValue() {
    if ( isSingleNumber ) {
      return number!;
    }
  }

  SnailfishNumber getRight() {
    if ( isSingleNumber ) {
      return SnailfishNumber(isSingleNumber: true, number: number);
    } else {
      return right!;
    }
  }
}

String exampleInputText ='target area: x=20..30, y=-10..-5';

String inputText = 'target area: x=209..238, y=-86..-59';
