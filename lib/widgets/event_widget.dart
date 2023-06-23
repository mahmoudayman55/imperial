import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/view/event_view.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

class EventWidget extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final bool showDetails;
  final Event event;
  final bool whiteLayer;

  const EventWidget(
      {required this.width,
      required this.height,
      super.key,
      this.whiteLayer = false,
      this.showDetails = true,
      required this.event,
      this.iconSize = 5});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(

      builder: (controller) {
        return GestureDetector(
          onTap: ()=>controller.getEvent(event.id),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: CustomCachedNetworkImage(
                      imageUrl: event.eventCovers[0].coverUrl,
                      width: width,
                      height: height),
                ),
                if (showDetails)
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                if (showDetails)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: width,
                    height: height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(DateFormat(
                                      'MMMM d, y')
                                      .format(
                                      event
                                          .appointment),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: Colors.amber)),
                                  Text(event.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.amber,
                                        size: (iconSize/100)*width,
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            event.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        //sponsors images row

                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     padding: EdgeInsets.all(8),
                        //     child: SizedBox(
                        //       height: height * 0.1,
                        //       child: ListView(
                        //         scrollDirection: Axis.horizontal,
                        //         children: [
                        //           Image.asset(
                        //             'assets/images/logo.png',
                        //             fit: BoxFit.fill,
                        //             height: height * 0.05,
                        //           ),
                        //
                        //           // Add more images here
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                if (whiteLayer)
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    );
  }
}
