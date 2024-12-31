import 'package:flutter/material.dart';

class ButtonStores extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final int index;
  final int activeButtonIndex;
  final Function(int) onButtonPressed;

  ButtonStores({
    required this.text,
    required this.onPressed,
    required this.index,
    required this.activeButtonIndex,
    required this.onButtonPressed,
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
          foregroundColor: Colors.white,
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
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 5),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 2,
              color: isActive ? Colors.white : Colors.transparent,
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
