import 'package:flutter/material.dart';

class WhiteChecker extends StatelessWidget {

  WhiteChecker(
      this.size
  );

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size,
      width: size,
    );
  }
}
