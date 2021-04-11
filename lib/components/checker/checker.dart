import 'package:checkers/components/square.dart';
import 'package:checkers/enums/checker-color.dart';

class Checker {
  final CheckerColor color;
  Square square;
  bool isQueen;

  Checker({
    this.square,
    this.color,
    this.isQueen = false,
  });

  Checker queenCheck() {
    if (isQueen) return this;
    final isWhite = color == CheckerColor.white;
    if (isWhite) return copyWith(isQueen: square.column == 0);
    return copyWith(isQueen: square.column == 7);
  }

  Checker copyWith({square, isQueen}) => Checker(
        square: square ?? this.square,
        isQueen: isQueen ?? this.isQueen,
        color: color,
      );
}
