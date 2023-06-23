import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:get/get.dart';
import '../auth_module/data/models/user_join_request_model.dart';
import '../core/utils/custom_colors.dart';

class UserJoinRequestWidget extends StatelessWidget {
  final UserJoinRequest request;
  final double width;
  final double height;

  UserJoinRequestWidget(
      {required this.request, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            request.communityName,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.black),
          ),
          request.status == 2
              ? Text(
                "Pending",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.amber),
              )
              : (request.status == 1
              ? Text(
            "Accepted",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.lightGreen),
          )
              : Text(
            "Declined",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: CustomColors.red),
          ))
        ],
      ),
    );
  }
}
