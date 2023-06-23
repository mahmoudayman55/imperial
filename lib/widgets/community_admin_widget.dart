import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';

import '../auth_module/domain/entities/user_entity.dart';

class CommunityAdminWidget extends StatelessWidget {
  final double width, height;
  final User admin;

  CommunityAdminWidget({
    required this.width, required this.height, required this.admin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(width: width,height: height,
      child: Column(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8),
            child:CustomCachedNetworkImage(imageUrl: admin.picUrl, width: width, height: height*0.8)
          ),
          Flexible(
            child: Text(
              admin.name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
