import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';

class ProductReviewWidget extends StatelessWidget {
final ServiceRateModel rateModel;

  const ProductReviewWidget({
    Key? key,
 required this.rateModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4.0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: CustomCachedNetworkImage(
                    imageUrl: rateModel.userPic, width: 10.w, height: 10.w),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rateModel.userName,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  ),
                  RatingBarIndicator(
                    rating: rateModel.rate,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 5.w,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            rateModel.comment,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
