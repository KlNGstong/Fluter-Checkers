import 'package:checkers/components/checker/checker.dart';
import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/square.dart';
import 'package:checkers/enums/checker-color.dart';

class CheckerGenerator {
  static List<Checker> normal() {
    Checkers checkers = Checkers();
    List<int> avalibleColumns = [0, 1, 2, 7, 6, 5];
    avalibleColumns.forEach((column) => List.generate(8, (row) {
          Square square = Square(column, row);
          if (!square.isWhite) {
            final color = column > 3 ? CheckerColor.white : CheckerColor.black;
            checkers.add(square, color);
          }
        }));
    return checkers.list;
  }
}
