
import 'package:advent_of_code/day18.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testString1 = '[[1,2],[[3,4],5]]';

  test('TokenProvider', () {
    TokenProvider tokenProvider = TokenProvider(testString1);
    expect(tokenProvider.getToken(), '[');
    expect(tokenProvider.getToken(), '[');
    expect(tokenProvider.getToken(), '1');
  });

  test('Snailfish pair', () {
    TokenProvider tokenProvider = TokenProvider('[1,2]');
    final pair = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(pair!.isSingleNumber, false);
    expect(pair.left!.getValue(), 1);
    expect(pair.right!.getValue(), 2);
  });

  test('Snailfish 2 levels', () {
    TokenProvider tokenProvider = TokenProvider('[1,[2,3]]');
    final sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.isSingleNumber, false);
    expect(sfn.left!.getValue(), 1);
    expect(sfn.right!.left!.getValue(), 2);
    expect(sfn.right!.right!.getValue(), 3);
  });

  test('Snailfish magnitudes', () {
    TokenProvider tokenProvider = TokenProvider('[[1,2],[[3,4],5]]');
    var sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getMagnitude(), 143);
    tokenProvider = TokenProvider('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getMagnitude(), 1384);
    tokenProvider = TokenProvider('[[[[1,1],[2,2]],[3,3]],[4,4]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getMagnitude(), 445);
    tokenProvider = TokenProvider('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getMagnitude(), 3488);
  });

  test('Snailfish depths', () {
    TokenProvider tokenProvider = TokenProvider('[[1,2],[[3,4],5]]');
    var sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getDepth(), 3);
    tokenProvider = TokenProvider('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getDepth(), 4);
    tokenProvider = TokenProvider('[[[[1,1],[2,2]],[3,3]],[4,4]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getDepth(), 4);
    tokenProvider = TokenProvider('[[[8,6],[7,7]],5]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.getDepth(), 3);
  });

  test('Snailfish strings', () {
    String s = '[1,2]';
    TokenProvider tokenProvider = TokenProvider(s);
    var sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.toSnailfishString(), s);

    s = '[[[[1,1],[2,2]],[3,3]],[4,4]]';
    tokenProvider = TokenProvider(s);
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.toSnailfishString(), s);

    s = '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]';
    tokenProvider = TokenProvider(s);
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    expect(sfn!.toSnailfishString(), s);
  });

  test('Snailfish addition', () {
    TokenProvider tokenProvider1 = TokenProvider('[1,2]');
    TokenProvider tokenProvider2 = TokenProvider('[[3,4],5]');
    var sfn1 = SnailfishNumber.fromTokenProvider(tokenProvider1);
    var sfn2 = SnailfishNumber.fromTokenProvider(tokenProvider2);
    var sfn3 = sfn1!.add(sfn2);
    expect( sfn3.toSnailfishString(), '[[1,2],[[3,4],5]]');
  });

  test('Snailfish getLeft and getRight', () {
    TokenProvider tokenProvider1 = TokenProvider('[1,2]');
    TokenProvider tokenProvider2 = TokenProvider('[[3,4],5]');
    TokenProvider tokenProvider3 = TokenProvider('[1,[3,4]]');
    var sfn1 = SnailfishNumber.fromTokenProvider(tokenProvider1);
    var sfn2 = SnailfishNumber.fromTokenProvider(tokenProvider2);
    var sfn3 = SnailfishNumber.fromTokenProvider(tokenProvider3);
    expect( sfn1!.getLeftAtLevel(1, 0), 1);
    expect( sfn2!.getLeftAtLevel(2, 0), 3);
    expect( sfn3!.getLeftAtLevel(2, 0), 3);
    expect( sfn1.getRightAtLevel(1, 0), 2);
    expect( sfn2.getRightAtLevel(2, 0), 4);
    expect( sfn3.getRightAtLevel(2, 0), 4);
  });

  test('Snailfish order numbering', () {
    TokenProvider tokenProvider = TokenProvider('[1,[2,3]]');
    var sfn = SnailfishNumber.fromTokenProvider( tokenProvider);
    sfn!.calcOrderNumbersPrepare();
    sfn.calcOrderNumbers();
    String s = sfn.snailfishStringWithOrderNumbers();
    expect(s,'[0|1,[1|2,2|3]]' );

    tokenProvider = TokenProvider('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]');
    sfn = SnailfishNumber.fromTokenProvider(tokenProvider);
    sfn!.calcOrderNumbersPrepare();
    sfn.calcOrderNumbers();
    s = sfn.snailfishStringWithOrderNumbers();
    expect(s,'[[[[0|8,1|7],[2|7,3|7]],[[4|8,5|6],[6|7,7|7]]],[[[8|0,9|7],[10|6,11|6]],[12|8,13|7]]]' );
  });

}

