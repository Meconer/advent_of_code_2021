import 'package:flutter/material.dart';

class Day21 extends StatelessWidget {
  const Day21({Key? key}) : super(key: key);
  static const String routeName = 'day21';
  static const String dayTitle = 'Day 21: Dirac Dice';

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
            SelectableText('Svar dag 21 del 1: $resultPart1'),
            SelectableText('Svar dag 21 del 2 : $resultPart2'),
          ],
        ),
      ),
    );
  }

  int doPart1() {
    GamePart1 game = getInput(example: false);
    return game.play();
  }

  int doPart2() {
    final game = getInputPart2(example: true);
    return Move.gameCount;
  }

  GamePart1 getInput({required bool example}) {
    String input = example ? exampleInputText : inputText;
    GamePart1 game = GamePart1.fromInputString(input);
    return game;
  }
  GamePart2 getInputPart2({required bool example}) {
    String input = example ? exampleInputText : inputText;
    GamePart2 game = GamePart2.fromInputString(input);
    return game;
  }
}

class GamePart2 {
  late int userPos1;
  late int userPos2;
  Map<int,int> rollMap = {};
  int user1Points = 0;
  int user2Points = 0;

  GamePart2(this.userPos1, this.userPos2);

  GamePart2.fromInputString(String input) {
    List<String> lines = input.split('\n');
    userPos1 = int.parse(lines[0].substring(lines[0].length - 2));
    userPos2 = int.parse(lines[1].substring(lines[1].length - 2));
    buildRollMap();
    Move move = Move();
    move.userNo = 0;  // User 0 starts
    move.userPos[0] = userPos1;
    move.userPos[1] = userPos2;
    move.doMove(rollMap,0);
    debugPrint('Games : ${Move.gameCount}');
  }

  buildRollMap() {
    for ( int roll1 = 1; roll1 <= 3; roll1++ ) {
      for ( int roll2 = 1; roll2 <= 3; roll2++ ) {
        for ( int roll3 = 1; roll3 <= 3; roll3++ ) {
          int sum = roll1 + roll2 + roll3;
          if (rollMap.containsKey(sum)) {
            rollMap[sum] = rollMap[sum]! + 1;
          } else {
            rollMap[sum] = 1;
          }
        }
      }
    }
    int diffRolls = 0;
    rollMap.forEach((key, sum) {
      debugPrint('Key : $key, sum : $sum');
      diffRolls += sum;
    });
    debugPrint('total rolls $diffRolls');
  }
}

class Move {
  static int gameCount = 0 ;
  List<Move> moveList = [];
  int userNo = 0;
  int count = 0;
  bool userWon = false;
  List<int> userPoint = [0,0];
  List<int> userPos =[0,0];

  List<Move> doMove(Map<int,int> rollMap, int userNo) {
    rollMap.forEach((diceValue, count) {
    //for ( int diceValue in rollMap.keys) {
      Move move = Move();
      move.count = count;
      gameCount += count;
      int otherUser =  userNo == 0 ? 1 : 0;
      int newPos = getNewPos(userPos[userNo], diceValue);
      move.userPos[userNo] = newPos;
      move.userPos[otherUser] = userPos[otherUser];
      move.userPoint[userNo] = userPoint[userNo] + newPos;
      move.userPoint[otherUser] = userPoint[otherUser];
      if ( move.userPoint[userNo] >= 21) {
        move.userWon = true;
      } else {
        move.doMove(rollMap, otherUser);
      }
      moveList.add(move);
    });
    return moveList;
  }

  int getNewPos(int userPos, int diceValue) {
    userPos = userPos + diceValue;
    while ( userPos > 10) {
      userPos -= 10;
    }
    return userPos;
  }
}
class GamePart1 {
  late int userPos1;
  late int userPos2;

  int user1Points = 0;
  int user2Points = 0;

  GamePart1(this.userPos1, this.userPos2);

  GamePart1.fromInputString(String input) {
    List<String> lines = input.split('\n');
    userPos1 = int.parse(lines[0].substring(lines[0].length - 2));
    userPos2 = int.parse(lines[1].substring(lines[1].length - 2));

  }

  int play() {
    DeterministicDie die = DeterministicDie();
    int userWon = 0;
    while ( true ) {
      userWon = doMove(die, 1000);
      if (userWon != 0 ) break;
    }
    debugPrint('User $userWon won' );

    if ( userWon == 1) {
      return user2Points * die.rolls;
    } else {
      return user1Points * die.rolls;
    }
  }

  // Returns 1 if user 1 wins and 2 for user 2. 0 if no win yet.
  int doMove(DeterministicDie die, int winValue) {
    userPos1 = doUserMove(userPos1, die);
    user1Points += userPos1;
    if ( user1Points >= winValue ) return 1;

    userPos2 = doUserMove(userPos2, die);
    user2Points += userPos2;
    if ( user2Points >= winValue ) return 2;

    return 0;
  }

  int doUserMove(int userPos, DeterministicDie die) {
    int diceVal = 0 ;
    for ( int i = 0 ; i < 3 ; i++ ) {
      diceVal += die.getValue();
    }
    userPos = userPos + diceVal;
    while ( userPos > 10) {
      userPos -= 10;
    }
    return userPos;
  }
}


class DeterministicDie {
  int _nextValue = 1;
  int rolls = 0;

  int getValue() {
    int valueToReturn = _nextValue;
    _nextValue++;
    rolls++;
    if (_nextValue>100 ) _nextValue = 1;
    return valueToReturn;
  }

  void setValue(int val) {
    _nextValue = val;
  }
}

String exampleInputText = '''Player 1 starting position: 4
Player 2 starting position: 8''';

String inputText = '''Player 1 starting position: 3
Player 2 starting position: 7''';
