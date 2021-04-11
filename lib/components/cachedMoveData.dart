import 'package:checkers/components/checker/checkers.dart';
import 'package:checkers/components/move-data.dart';

class CachedMoveData {
  List<MoveData> stack = [];
  Checkers checkers;
  int deep = 0;

  CachedMoveData clone() {
    final data = CachedMoveData(checkers.clone());
    data.stack = []..addAll(stack);
    data.deep = 0 + deep;
    return data;
  }

  CachedMoveData(this.checkers);
}
