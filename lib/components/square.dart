import 'package:checkers/components/game/gameRules.dart';

class Square {
  final int column;
  final int row;

  int get getIndex => column * 10 + row;

  bool get isWhite => column % 2 == 0 ? row % 2 == 0 : row % 2 != 0;

  bool get isOverflow => column > 7 || row > 7 || row < 0 || column < 0;

  static Square getSide(Square start, Square end) {
    final difference = start - end;
    return Square(
      difference.column > 0 ? 1 : -1, 
      difference.row > 0 ? 1 : -1
    ); 
  }

  Square operator /(int) => Square(column ~/ int, row ~/ int);

  Square operator -(Square square) =>
      Square(column - square.column, row - square.row);

  Square operator +(Square square) =>
      Square(column + square.column, row + square.row);

  Square operator *(int) => Square(column * int, row * int);

  Square(this.column, this.row);
}
