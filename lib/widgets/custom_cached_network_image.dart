import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/view/loading_screen.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  CustomCachedNetworkImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        color: Colors.grey[300],
        width: width,
        height: height,
        child: Center(
          child: LoadingScreen(width * 0.1),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',fit: BoxFit.cover,),
    );
  }
}