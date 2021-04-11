import 'package:checkers/components/bot/bot-controller.dart';
import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/game/gameRules.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/components/tap-details.dart';
import 'package:checkers/enums/checker-color.dart';
import 'package:checkers/enums/game-type.dart';
import 'package:flutter/cupertino.dart';

import 'game-settings.dart';

class GameController extends ChangeNotifier {
  static GameSettings settings;
  static CheckerColor turnColor = CheckerColor.white;
  BotController botController = BotController();
  TapDetails tapDetails = TapDetails();
  GameRules gameRules;
  Checkers checkers = Checkers();

  bool get couldTurn =>
      !(settings.type == GameType.single && turnColor == CheckerColor.black);

  void init(GameSettings initSettings) {
    settings = initSettings;
    gameRules = GameRules(checkers);
    if (settings.type == GameType.single) botController.init(this);
    checkers.init();
  }

  void onTurnEnd() {
    turnColor = oppositeTurn;
    if (!couldTurn) botController.turn();
    turnColor = oppositeTurn;
  }

  static CheckerColor oppositeColor(color) =>
      color == CheckerColor.white ? CheckerColor.black : CheckerColor.white;

  CheckerColor get oppositeTurn =>
      turnColor == CheckerColor.white ? CheckerColor.black : CheckerColor.white;

  void move(Square square) {
    final moveData = gameRules.getMoveData(tapDetails.tapped, square);
    checkers.list = checkers.getMoved(moveData).list;
    tapDetails.clear();
    bool isAggressive = gameRules.isAggressive(checkers.findChecker(square));
    if (moveData.killed.isNotEmpty && isAggressive) {
      tapDetails.uncompleted = square;
      onTap(square);
    } else
      onTurnEnd();
  }

  void onTap(Square square) {
    tapDetails.aggressive = gameRules.getAggressiveByColor();
    if (tapDetails.isThere(square))
      move(square);
    else if (tapDetails.uncompleted == null ||
        tapDetails.uncompleted.getIndex == square.getIndex) {
      tapDetails.tapped = square;
      tapDetails.active = gameRules.getActive(square, tapDetails);
    }
    notifyListeners();
  }
}
