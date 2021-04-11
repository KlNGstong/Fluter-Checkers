

import 'package:checkers/utils/screen-manage.dart';
import 'package:flutter/cupertino.dart';

class OpacityTransition extends PageRouteBuilder {
  OpacityTransition({
    child,
  }) : super(
      pageBuilder: (context, firstAnim, secondAnim) {
        return child;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 200)
  );
}

class RightTransition extends PageRouteBuilder {
  RightTransition({
    child,
  }) : super(
      pageBuilder: (context, firstAnim, secondAnim) {
        return child;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(1.0, 0.0);
        final end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 200)
  );
}
