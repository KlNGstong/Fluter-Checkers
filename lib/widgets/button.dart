import 'package:checkers/utils/screen-manage.dart';
import 'package:flutter/material.dart';


class Button extends StatefulWidget {

  Button({
    this.color = Colors.lightGreen,
    this.onTap,
    this.child,
    this.width,
    this.height = 50
  });
  final double height;
  final Widget child;
  final Function onTap;
  final Color color;
  final double width;
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100
      )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = Size(
        this.widget.width ?? ScreenManage.width * 0.7,
        this.widget.height
    );

    return Listener(
      onPointerDown: (details) {
        controller.forward();
      },
      onPointerUp: (d) {
        controller.reverse();
        if (this.widget.onTap != null)
          this.widget.onTap();
      },
      child: AnimatedBuilder(
        animation: controller,
        child: Center(
          child: this.widget.child,
        ),
        builder: (context, child) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: this.widget.color,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
                ),
                height: size.height -  5 * controller.value,
                width: size.width - 5 * controller.value,
                child: child
              ),
            ),
          );
        }
      ),
    );
  }
}
