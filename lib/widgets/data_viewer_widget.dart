import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';

import '../core/utils/custom_colors.dart';

class DataViewerWidget extends StatelessWidget{
  double iconSize;
  String data;
  IconData iconData;

  DataViewerWidget({required this.iconSize,required this.data,required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
return    Container(
  decoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.3),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: Icon(
             iconData,
              color: Colors.black45,
              size: iconSize,
            ),
          ),
          Text(
            data,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          )
        ],
      ),
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: data));
          customSnackBar(title: "Done!", message: "copied to your clipboard", successful: true);

        },
        icon: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0),
          child: Icon(
            Icons.copy,
            color: CustomColors.red,
            size: iconSize,
          ),
        ),
      )
    ],
  ),
);
  }

}