import 'package:checkers/components/game/gameController.dart';
import 'bot-algorithm.dart';

class BotController {
  GameController gameController;
  BotAlgorithm botAlgorithm;

  void turn() {
    final stack = botAlgorithm.getAlgorithmDecision();
    stack.forEach(gameController.onTap);
  }

  void init(GameController gameController) {
    this.gameController = gameController;
    botAlgorithm = BotAlgorithm(gameController.checkers);
  }
}
