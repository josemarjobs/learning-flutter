import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final borderRadius;
  final VoidCallback onPressed;
  final double height;

  CustomRaisedButton({
    @required this.child,
    this.color,
    this.borderRadius: 4.0,
    this.onPressed,
    this.height: 50.0,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        disabledColor: color.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
