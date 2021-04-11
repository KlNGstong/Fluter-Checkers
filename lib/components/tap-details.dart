import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/square.dart';

class TapDetails {
  Square tapped;
  List<Square> active = [];
  Checkers aggressive = Checkers();
  Square uncompleted;

  void clear() {
    tapped = null;
    active = [];
    uncompleted = null;
  }

  bool isThere(Square square) {
    if (tapped == null) return false;
    return active.indexWhere(
      (el) => el.getIndex == square.getIndex) != -1;
  }
}