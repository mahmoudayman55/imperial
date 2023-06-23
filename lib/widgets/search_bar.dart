import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/utils/custom_colors.dart';

class SearchBar extends StatelessWidget {
final  double height, width,iconSize;
TextEditingController controller;
Color color;

  Function() onTapSearch;

  SearchBar(
      {Key? key,  this.iconSize=5,required this.height, this.color=CustomColors.red, required this.width,required this.controller,
        required this.onTapSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: height,
                  width: width * 0.15,
                  child: Icon(
                    Icons.search,
                    size: iconSize.w,
                  )),
              SizedBox(
                width: width * 0.55,
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                      fontSize: 12.sp, color: Colors.black),
                  decoration: InputDecoration.collapsed(
                      hintText: 'Search...'.tr,
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.2,
                height: height,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                    onPressed: onTapSearch,
                    icon: Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                      size: iconSize.w,
                    )),
              )
            ],
          ),
        ),
      ],
    );
    throw UnimplementedError();
  }
}
