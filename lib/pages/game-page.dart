import 'package:checkers/providers/gameProvider.dart';
import 'package:checkers/utils/screen-manage.dart';
import 'package:checkers/utils/styles.dart';
import 'package:checkers/widgets/button.dart';
import 'package:checkers/widgets/gameBoard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, child, provider) {
        return WillPopScope(
          onWillPop: () {},
          child: Scaffold(
            floatingActionButton: Button(
              color: Colors.red,
              width: 70,
              height: 70,
              child: Text(
                'Draw',
                style: Styles.buttonText,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Center(
              child: GameBoard(),
            )
          ),
        );
      }
    );
  }
}
