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
    final tokenProvider = TokenProvider(getInput(isExample));
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
  bool? isSingleNumber = false;
  int? number;
  int? orderNumber;
  SnailfishNumber? left, right;

  static SnailfishNumber? fromTokenProvider(TokenProvider tokenProvider) {
    SnailfishNumber snailfishNumber = SnailfishNumber();
    String token = tokenProvider.getToken();
    if ( token == '[') {
      snailfishNumber.left = SnailfishNumber.fromTokenProvider(tokenProvider);
      token = tokenProvider.getToken();
    }
    if ( token == ',') {
      snailfishNumber.right = SnailfishNumber.fromTokenProvider(tokenProvider);
      token = tokenProvider.getToken();
    }
    if ( token == ']') return snailfishNumber;
    if (isDigit(token)) {
      snailfishNumber.isSingleNumber = true;
      snailfishNumber.number = int.parse(token);
      return snailfishNumber;
    }
  }

  int getDepth() {
    if ( isSingleNumber!) return 0 ;
    int leftDepth = left!.getDepth();
    int rightDepth = right!.getDepth();
    if (leftDepth > rightDepth )  return 1 + leftDepth;
    return 1 + rightDepth;
  }

  static int orderNo = 0;

  calcOrderNumbersPrepare() {
    orderNo = 0;
  }

  calcOrderNumbers() {
    if ( isSingleNumber!) {
      orderNumber = orderNo++;
    } else {
      left!.calcOrderNumbers();
      right!.calcOrderNumbers();
    }
  }

  String toSnailfishString() {
    if (isSingleNumber!) return number.toString();
    String s = '[' + left!.toSnailfishString() + ',' + right!.toSnailfishString() + ']';
    return s;
  }

  int getMagnitude() {
    if ( isSingleNumber! ) {
      return number!;
    }
    return 3 * left!.getMagnitude() + 2 * right!.getMagnitude();
  }

  SnailfishNumber getLeft() {
    return left!;
  }

  int? getValue() {
    if ( isSingleNumber! ) {
      return number!;
    }
  }

  SnailfishNumber getRight() {
      return right!;
  }

  explode() {
    if ( getDepth() > 4 ) {
      int currentLevel = 1;
      int? leftValue = getLeftAtLevel(5, currentLevel);
    }
  }

  int? getLeftAtLevel(int levelToFind, int currentLevel) {
    if (levelToFind == currentLevel) {
      if (isSingleNumber!) {
        return number;
      } else {
        throw('This is wrong');
      }
    } else {
      if ( isSingleNumber!) return null;
      int? value = left!.getLeftAtLevel(levelToFind, currentLevel + 1 );
      value ??= right!.getLeftAtLevel(levelToFind, currentLevel +1);
      return value;
    }
  }

  int? getRightAtLevel(int levelToFind, int currentLevel) {
    if (levelToFind == currentLevel) {
      if (isSingleNumber!) {
        return number;
      } else {
        throw('This is wrong');
      }
    } else {
      if ( isSingleNumber!) return null;
      int? value = right!.getRightAtLevel(levelToFind, currentLevel + 1 );
      value ??= left!.getRightAtLevel(levelToFind, currentLevel +1);
      return value;
    }
  }

  SnailfishNumber add(SnailfishNumber? sfn2) {
    SnailfishNumber snailfishNumber = SnailfishNumber();
    snailfishNumber.isSingleNumber = false;
    snailfishNumber.left = this;
    snailfishNumber.right = sfn2;
    return snailfishNumber;
  }

  String snailfishStringWithOrderNumbers() {
    if (isSingleNumber!) return orderNumber!.toString() +'|' + number.toString();
    String s = '[' + left!.snailfishStringWithOrderNumbers() + ',' + right!.snailfishStringWithOrderNumbers() + ']';
    return s;

  }

}

bool isDigit(String char) {
    final digitRegex = RegExp(r'\d');
    if ( digitRegex.hasMatch(char) ) {
      return true;
    }
    return false;
}

class TokenProvider {
  String tokenStr;

  TokenProvider(this.tokenStr);

  String getToken() {
    String nextChar = getNextChar();
    if ( '[],'.contains(nextChar) ) return nextChar;

    String s = nextChar;
    while ( nextIsDigit() ) {
      s += nextChar;
    }
    return s;
  }

  bool nextIsDigit() {
    final digitRegex = RegExp(r'\d');
    if ( digitRegex.hasMatch(tokenStr[0])) {
      return true;
    }
    return false;
  }

  bool hasTokens() {
    return tokenStr.isNotEmpty;
  }

  String getNextChar() {
    String s = tokenStr[0];
    tokenStr = tokenStr.substring(1);
    return s;
  }
}

String exampleInputText ='target area: x=20..30, y=-10..-5';

String inputText = 'target area: x=209..238, y=-86..-59';
