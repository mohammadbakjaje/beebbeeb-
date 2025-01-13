import 'package:flutter/material.dart';

class ButtonStores extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final int index;
  final int activeButtonIndex;
  final Function(int) onButtonPressed;
  final Color textColor; // أضف هذا المعامل

  ButtonStores({
    required this.text,
    required this.onPressed,
    required this.index,
    required this.activeButtonIndex,
    required this.onButtonPressed,
    required this.textColor, // أضف هذا المعامل
  });

  @override
  ButtonStoresState createState() => ButtonStoresState();
}

class ButtonStoresState extends State<ButtonStores> {
  void _handlePress() {
    widget.onButtonPressed(widget.index);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.activeButtonIndex == widget.index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: TextButton(
        onPressed: _handlePress,
        style: TextButton.styleFrom(
          foregroundColor: widget.textColor, // استخدم textColor هنا
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Column(
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: widget.textColor, // استخدم textColor هنا
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 5),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 2,
              color: isActive ? widget.textColor : Colors.transparent, // استخدم textColor هنا
              width: (TextPainter(
                text: TextSpan(
                    text: widget.text,
                    style:
                    TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                maxLines: 1,
                textDirection: TextDirection.ltr,
              )..layout())
                  .size
                  .width,
            ),
          ],
        ),
      ),
    );
  }
}