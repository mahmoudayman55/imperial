import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

import 'event_widget.dart';

class EventSlider extends StatefulWidget {
  final List<Event> events;
  final double height;
  final bool showEventDetails;
  final double width;
  final double scale;
  final Axis scrollDirection;

  const EventSlider(
      {required this.events,
      required this.height,
      required this.width,
      this.scrollDirection = Axis.horizontal,
      this.showEventDetails = true,
      this.scale = 1});

  @override
  _EventSliderState createState() => _EventSliderState();
}

class _EventSliderState extends State<EventSlider> {
  final PageController controller = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        controller: controller,
        scrollDirection: widget.scrollDirection,
        itemCount: widget.events.length,
        onPageChanged: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Transform.scale(
            alignment: Alignment.center,
            scale: index == currentPage ? widget.scale : widget.scale - 0.15,
            child: EventWidget(showDetails: widget.showEventDetails,
                width: widget.width ,
                height: widget.height,
                event: widget.events[index]),
          );
        },
      ),
    );
  }
}
