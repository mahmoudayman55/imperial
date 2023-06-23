import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final void Function() onPressed;
  final double width;
  final double height;
  final String icon;

  const SocialMediaButton({
    Key? key,
    required this.onPressed,
    this.icon = 'facebook',
    this.width = 40.0,
    this.height = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: width,
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Image(image: AssetImage('assets/images/$icon.png')),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
