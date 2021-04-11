import 'package:checkers/components/cachedMoveData.dart';
import 'package:checkers/components/checker/checker.dart';
import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/game/gameRules.dart';
import 'package:checkers/components/move-data.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/enums/checker-color.dart';

class BotAlgorithm {
  Checkers checkers;
  final int deeps = 5;

  List<Square> mainAlgorithm(Checkers availableCheckers) {
    List<CachedMoveData> data = [];
    List<CachedMoveData> completed = [];
    availableCheckers.list.forEach((checker) {
      final turns = checkers.getRules().moveCompleter(checker);
      data.addAll(checkers.getCached(turns));
    });
    int counter = 0;
    do {
      final iterator = data[0];
      final color = iterator.stack.length % 2 == 0
          ? CheckerColor.black
          : CheckerColor.white;
      final gameRules = iterator.checkers.getRules();
      final available = gameRules.getAvailableByColor(color);
      available.list.forEach((checker) {
        final turns = gameRules.moveCompleter(checker);
        turns.forEach((turn) {
          final current = iterator.clone()
            ..checkers = iterator.checkers.getMoved(turn)
            ..stack = [...iterator.stack, turn]
            ..deep += 1;
          counter++;
          if (current.deep == deeps)
            completed.add(current);
          else
            data.add(current);
        });
      });
      data.removeAt(0);
    } while (data.length != 0);
    print(counter);
    checkers = completed.last?.checkers ?? checkers;
    checkers.drawBoard();
    return [];
  }

  List<Square> getAlgorithmDecision() {
    final gameRules = checkers.getRules();
    final available = gameRules.getAvailableByColor();
    return mainAlgorithm(available);
  }

  BotAlgorithm(
    this.checkers,
  );
}
