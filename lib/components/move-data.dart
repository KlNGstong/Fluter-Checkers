
import 'package:checkers/components/checker/checker.dart';
import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/square.dart';

class MoveData {
  Checker root;
  List<Checker> killed = [];
  List<Square> stack = [];

  MoveData unite(MoveData data) {
    MoveData unitedData = this.copy();
    unitedData.killed..addAll(data.killed);
    unitedData.stack..addAll(data.stack.sublist(1));
    unitedData.root = data.root;
    return unitedData;
  }

  MoveData copy() {
    MoveData copied = MoveData();
    copied.root = root.copyWith();
    copied.stack = []..addAll(stack);
    copied.killed = []..addAll(killed);
    return copied;
  }
}