import 'package:flutter/material.dart';

class SwipeAppArrow extends StatefulWidget {
  final void Function() onSwipe;

  const SwipeAppArrow({Key? key, required this.onSwipe}) : super(key: key);

  @override
  _SwipeAppArrowState createState() => _SwipeAppArrowState();
}

class _SwipeAppArrowState extends State<SwipeAppArrow> {
  double _arrowPosition = 0.0;
  bool _arrowVisible = true;
  bool _swiped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _arrowVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 250),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _arrowPosition -= details.delta.dy;

            if (_arrowPosition > 64.0) {
              _arrowPosition = 64.0;
            } else if (_arrowPosition < -64.0) {
              _arrowPosition = -64.0;
            }
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            if (_arrowPosition > 48.0) {
              _arrowVisible = false;
              if (!_swiped) {
                widget.onSwipe();
                _swiped = true;
              }
            }
            _arrowPosition = 0.0;
          });
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0.0, _arrowPosition, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 32.0),
              SizedBox(height: 8.0),
              Text('Swipe To Sign Up', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
