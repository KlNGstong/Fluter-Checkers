import 'package:checkers/enums/game-type.dart';
import 'package:checkers/enums/routes.dart';
import 'package:checkers/pages/game-page.dart';
import 'package:checkers/pages/root/main-root-page.dart';
import 'package:checkers/providers/gameProvider.dart';
import 'package:checkers/providers/root-provider.dart';
import 'package:checkers/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void runApplication () {
  final GameProvider gameProvider = GameProvider();
  gameProvider.setType(GameType.friend);
  runApp(
      App(
          gameProvider: gameProvider
      )
  );
}



class App extends StatefulWidget {

  App({
    this.gameProvider
  });

  final GameProvider gameProvider;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => this.widget.gameProvider,
      builder: (context, snapshot) {
        return MaterialApp(
          onGenerateRoute: onGenerateRoute,
          initialRoute: Routes.MAIN_ROOT_PAGE,
        );
      }
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case Routes.MAIN_ROOT_PAGE:
        return OpacityTransition(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<RootProvider>(
                create: (_) => RootProvider(),
              ),
            ],  
            builder: (context, child) => MainRootPage(),
          ),
        );
      case Routes.GAME_PAGE:
        return OpacityTransition(
            child: GamePage()
        );  
      default:
        return null;
    }
  }
}
