import 'package:checkers/components/game/gameController.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/enums/checker-color.dart';
import 'package:checkers/providers/gameProvider.dart';
import 'package:checkers/utils/screen-manage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  double get boardSize => 
    ScreenManage.width * .85;

  double get squareSize => 
    boardSize / 8;


  GameProvider get provider =>
    Provider.of<GameProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenManage.width * .97,
      width: ScreenManage.width * .97,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
            Radius.circular(10)
        )
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: provider.gameController,
          builder: (context, child) {
            return Container(
              height: boardSize,
              width: boardSize,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                )
              ),
              child: Table(
                children: List.generate(
                  8, 
                  (column) => TableRow(
                    children: List.generate(
                      8,
                      (row) => square(Square(column, row))
                    ) 
                  )
                )
              ),
            );
          }
        )
      ),  
    );
  }

  Widget square(Square square) {
    // square = Square(7, 7) - square;
    final checker = provider.gameController.checkers.findChecker(square); 
    final tapDetails = provider.gameController.tapDetails;
    var template;
    if (checker != null)
      template = Center(
        child: Container(
          height: squareSize * .6 ,
          width: squareSize * .6,
          decoration: BoxDecoration(
            color: checker.color == CheckerColor.black ? 
              Colors.black54 : Colors.white,
            border: Border.all(
              color: tapDetails.tapped?.getIndex == square.getIndex ?
                  Colors.red :
                  Colors.transparent,
              width: 3
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(10)
            )
          ),
          child: Center(
            child: Container(
              height: squareSize * .2,
              width: squareSize * .2,
              decoration: BoxDecoration(
                color: checker.isQueen ? 
                  Colors.yellow : Colors.transparent,
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                )
              ),
            ),
          ),
        ),
      );
    else if (tapDetails.isThere(square)) 
      template = Padding(
        padding: EdgeInsets.all(squareSize * .4),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
          ),
        ),
      );
    final squareColor = square.isWhite ?
          Colors.white :
          Colors.transparent;

    return GestureDetector(
      onTap: () {
        print(square.getIndex);
        if (provider.gameController.couldTurn) 
          provider.gameController.onTap(square);
      },
      child: AnimatedContainer(
        duration: Duration(
          microseconds: 200 
        ),
        height: squareSize,
        width: squareSize,
        color: squareColor,
        child: template
      ),
    );
  }
}
