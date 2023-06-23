import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/service_module/domain/entity/service_item.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';

class ServiceItemWidget extends StatelessWidget {
  final ServiceItem serviceItem;
  final double width;
  final double height;

  ServiceItemWidget(
      {required this.serviceItem, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4.0,
            )           ]),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: CustomCachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: serviceItem.imageUrl,
                width: width ,
                height: height),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                serviceItem.name,
                maxLines: 10,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black),textAlign: TextAlign.center,
              ),
              Text(
                serviceItem.description,maxLines: 4,overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
