import 'package:checkers/components/checker/checker.dart';
import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/game/gameController.dart';
import 'package:checkers/components/move-data.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/components/tap-details.dart';
import 'package:checkers/enums/checker-color.dart';

class GameRules {
  final Checkers checkers;
  static List<Square> negativeAround = [Square(-1, -1), Square(-1, 1)];
  static List<Square> positiveAround = [Square(1, 1), Square(1, -1)];
  static List<Square> around = [...negativeAround, ...positiveAround];

  GameRules(this.checkers);

  List<MoveData> moveCompleter(Checker checker) {
    List<MoveData> completed = [];
    final aggressive = getAggressiveSquares(checker);
    final moves = getTurn(checker.square).map((to) {
      return getMoveData(checker.square, to);
    }).toList();
    if (aggressive.isEmpty) return moves;
    do {
      final moveData = moves[0];
      final gameRules = checkers.getMoved(moveData).getRules();
      final aggressive = gameRules.getAggressiveSquares(moveData.root);
      List<MoveData> createdMove = aggressive
          .map((to) =>
              moveData.unite(gameRules.getMoveData(moveData.root.square, to)))
          .toList();
      if (aggressive.isEmpty) completed.add(moveData);
      moves.addAll(createdMove);
      moves.removeAt(0);
    } while (moves.length != 0);
    return completed;
  }

  bool isRightChecker(Square square) {
    final checker = checkers.findChecker(square);
    return checker?.color == GameController.turnColor;
  }

  bool isAggressive(Checker checker) =>
      getAggressiveSquares(checker).isNotEmpty;

  List<Square> getAggressiveSquares(Checker checker) {
    final turns = checker.isQueen
        ? getKillTurnQueen(checker)
        : getKillTurnChecker(checker);
    return turns;
  }

  Checkers getAggressiveByColor([color]) {
    List<Checker> aggressive = [];
    checkers.getByColor(color ?? GameController.turnColor).list.forEach((checker) {
      if (isAggressive(checker)) aggressive.add(checker);
    });
    return Checkers(list: aggressive);
  }

  Checkers getAvailableByColor([color]) {
    List<Checker> available = [];
    final aggressive = getAggressiveByColor(color ?? GameController.turnColor);
    if (!aggressive.isEmpty) return aggressive;
    checkers.getByColor(color ?? GameController.turnColor).list.forEach((checker) {
      final turn = getTurn(checker.square);
      if (turn.isNotEmpty) available.add(checker);
    });
    return Checkers(list: available);
  }

  MoveData getMoveData(Square who, Square to) {
    final moveData = MoveData();
    moveData.stack.addAll([who, to]);
    moveData.root = checkers.findChecker(who).copyWith(square: to).queenCheck();
    final side = Square.getSide(to, who);
    for (Square current = who + side;
    current.getIndex != to.getIndex;
    current += side) {
      final index = checkers.findIndex(current);
      if (index != -1) {
        moveData.killed.add(checkers.findChecker(current));
      }
    }
    return moveData;
  }

  List<Square> getActive(Square square, TapDetails tapDetails) {
    if (!isRightChecker(square)) return [];
    if (tapDetails.aggressive.isEmpty) {
      return getTurn(square);
    } else {
      final aggressive = tapDetails.aggressive.findChecker(square);
      if (aggressive == null) return [];
      return getTurn(square);
    }
  }

  List<Square> getTurn(Square square) {
    final checker = checkers.findChecker(square);
    if (checker.isQueen)
      return queenTurn(square);
    else
      return checkerTurn(square);
  }

  List<Square> queenTurn(Square square) {
    final checker = checkers.findChecker(square);
    final killTurns = getKillTurnQueen(checker);
    if (killTurns.length != 0) return killTurns;
    return getTurnQueen(checker);
  }

  List<Square> checkerTurn(Square square) {
    final checker = checkers.findChecker(square);
    final navigators =
        checker.color == CheckerColor.white ? negativeAround : positiveAround;
    final killTurns = getKillTurnChecker(checker);
    if (killTurns.length != 0) return killTurns;
    return getTurnChecker(navigators, checker);
  }

  List<Square> getTurnQueen(Checker checker) {
    List<Square> list = [];
    for (var navigator in around) {
      for (var i = 1; i < 8; i++) {
        final square = checker.square + navigator * i;
        final killTurn =
            getCustomKillTurn(square - navigator, navigator, checker.color);
        final turn = getCustomTurn(square - navigator, navigator);
        if (square.isOverflow) break;
        if (killTurn != null) return [];
        if (turn == null) break;
        list.add(turn);
      }
    }
    return list;
  }

  List<Square> getKillTurnQueen(Checker checker) {
    List<Square> list = [];
    around.forEach((navigator) {
      bool killedOne = false;
      for (var i = 1; i < 8; i++) {
        final square = checker.square + navigator * i;
        if (square.isOverflow) break;
        if (killedOne) {
          final turn = getCustomTurn(square - navigator, navigator);
          if (turn == null) break;
          list.add(turn);
        } else {
          final turn =
              getCustomKillTurn(square - navigator, navigator, checker.color);
          if (turn == null) continue;
          killedOne = true;
        }
      }
    });
    return list;
  }

  List<Square> getTurnChecker(List<Square> navigators, Checker checker) {
    final List<Square> list = [];
    for (var navigator in navigators) {
      final turn = getCustomTurn(checker.square, navigator);
      if (turn == null) continue;
      list.add(turn);
    }
    return list;
  }

  List<Square> getKillTurnChecker(Checker checker) {
    final List<Square> list = [];
    for (var navigator in around) {
      final killTurn = getCustomKillTurn(checker.square, navigator);
      if (killTurn == null) continue;
      list.add(killTurn);
    }
    return list;
  }

  Square getCustomKillTurn(Square who, Square side, [CheckerColor color]) {
    Square square(times) => who + side * times;
    final closestNeighbor = checkers.findChecker(square(1));
    final checker = checkers.findChecker(square(0));
    if (closestNeighbor == null) return null;
    final isOpposite = (checker?.color ?? color) != closestNeighbor.color;
    final farthestNeighbor = checkers.isThere(square(2));
    if (isOpposite && !farthestNeighbor && !square(2).isOverflow) {
      return square(2);
    }
    return null;
  }

  Square getCustomTurn(Square who, Square side) {
    final square = who + side;
    final closestNeighbor = checkers.findChecker(square);
    if (closestNeighbor == null && !square.isOverflow) return square;
    return null;
  }
}
