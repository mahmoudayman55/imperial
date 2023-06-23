import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';

import '../auth_module/domain/entities/user_entity.dart';

class UserInfoHeader extends StatelessWidget {
  final User user;
  final double height;
  final double width;

  UserInfoHeader(
      {required this.height, required this.width, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child:ClipOval(
              child: CustomCachedNetworkImage(
                imageUrl: user.picUrl,
                width: width * 0.15,
                height: width * 0.15,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.grey),
              ),
              Flexible(
                child: SizedBox(
                  width: width * 0.5,
                  child: Text(
                    user.email,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
