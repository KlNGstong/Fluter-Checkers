

import 'file:///C:/Users/KINGstong/AndroidStudioProjects/checkers/lib/components/bot/bot-controller.dart';
import 'package:checkers/components/game/game-settings.dart';
import 'package:checkers/components/game/gameController.dart';
import 'package:checkers/enums/game-type.dart';
import 'package:flutter/cupertino.dart';

class GameProvider extends ChangeNotifier {
  GameSettings settings = GameSettings( );
  GameController gameController = GameController();
  
  void setType([ String type ]) {
    settings.type = type;
    notifyListeners();
  }

  void init() {
    gameController.init(settings);  
  } 
 
}