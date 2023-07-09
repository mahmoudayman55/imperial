import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:get/get.dart';
import '../core/utils/custom_colors.dart';

class CommunityJoinRequestWidget extends StatelessWidget {
  final CommunityJoinRequest request;
  final double width;
  final double height;

  CommunityJoinRequestWidget(
      {required this.request, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
    Get.toNamed(AppConstants.personProfilePage,arguments: request.user.id);
    },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2,
              child: Row(
                children: [
                  Expanded(flex: 1,
                    child: ClipOval(
                      child: CustomCachedNetworkImage(
                          imageUrl: request.user.picUrl,
                          width: width * 0.15,
                          height: width * 0.15),
                    ),
                  ),
                  Expanded(flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.user.name,overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black),
                          ),
                          Text(request.user.region!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey)),
                          Text("${request.user.speakingLanguage!.name} speaker",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey)),
                          Text("between ${request.user.groupAge!.groupAge} yo",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            request.status == 2
                ? Expanded(flex: 1,
                    child: GetBuilder<CommunityJoinRequestsController>(builder: (controller) {
                      return Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {
                                    log("req u id: ${request.user.id}");
                                    controller.acceptJoinRequest(
                                      request.user.id, request.id,request.user.deviceToken);
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: width * 0.06,
                                  ))),    Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () =>controller.declineJoinRequest(
                      request.user.id, request.id,request.user.deviceToken),
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: width * 0.06,
                                  )))
                        ],
                      );

                    }),
                  )
                : (request.status == 1
                    ? Expanded(flex: 1,
                      child: Text(
                          "Accepted",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.lightGreen),textAlign: TextAlign.center,
                        ),
                    )
                    : Expanded(flex: 1,
                      child: Text(
                          "Declined",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: CustomColors.red),textAlign: TextAlign.center,
                        ),
                    ))
          ],
        ),
      ),
    );
  }
}
