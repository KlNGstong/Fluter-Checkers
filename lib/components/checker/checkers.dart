import 'package:checkers/components/cachedMoveData.dart';
import 'package:checkers/components/checker/checker-generator.dart';
import 'package:checkers/components/checker/checker.dart';
import 'package:checkers/components/game/gameController.dart';
import 'package:checkers/components/game/gameRules.dart';
import 'package:checkers/components/move-data.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/enums/checker-color.dart';

class Checkers {
  Checkers({
    this.list = const <Checker>[],
  });

  List<Checker> list;

  // int ratingByColor(color) {

  //   list.forEach((checker) {
  //     if (checker.isQueen)
  //   });

  //   return 0;
  // }

  void add(Square square, CheckerColor color, [bool isQueen = false]) {
    final checker = Checker(square: square, color: color, isQueen: isQueen);
    list = [...list, checker];
  }

  List<CachedMoveData> getCached(List<MoveData> data) {
    return data.map((e) {
      final cached = CachedMoveData(getMoved(e));
      cached.stack.add(e);
      return cached;
    }).toList();
  }

  Checker findChecker(Square square) {
    final index = findIndex(square);
    return index == -1 ? null : list[index];
  }

  bool get isEmpty => list.isEmpty;

  bool isThere(Square square) => findIndex(square) != -1;

  int findIndex(Square square) =>
      list.indexWhere((checker) => checker.square.getIndex == square.getIndex);

  Checkers getByColor(CheckerColor color) =>
      Checkers(list: list.where((el) => el.color == color).toList());

  Checkers getMoved(MoveData moveData) {
    final checkers = clone();
    moveData.killed
        .forEach((e) => checkers.list.removeAt(checkers.findIndex(e.square)));
    checkers.list.removeAt(checkers.findIndex(moveData.stack[0]));
    checkers.list.add(moveData.root);
    checkers.list.add(Checker(
        square: Square(100, 100), color: CheckerColor.black, isQueen: true));
    return checkers;
  }

  GameRules getRules() => GameRules(this);

  Checkers clone() {
    final Checkers checkers = Checkers();
    checkers.list = []..addAll(list);
    return checkers;
  }

  void drawBoard() {
    List<List<String>> data =
        List.generate(8, (index) => List.generate(8, (index) => '#'));
    list.forEach((checker) => !checker.square.isOverflow
        ? data[checker.square.column][checker.square.row] =
            checker.color == CheckerColor.black ? 'B' : 'W'
        : null);
    data.forEach((el) => print(el));
    print('------------------------------------------------');
  }

  void init() {
    list = CheckerGenerator.normal();
  }
}
