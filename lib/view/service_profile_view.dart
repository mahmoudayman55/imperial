import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/core/utils/custom_url_luncher.dart';
import 'package:imperial/service_module/domain/entity/service.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:imperial/widgets/review_widget.dart';
import 'package:imperial/widgets/service_item_widget.dart';
import '../app_init_module/presentation/controller/region_controller.dart';
import '../core/utils/custom_colors.dart';
import '../service_module/data/model/service_item_model.dart';
import '../service_module/domain/entity/service_item.dart';
import '../service_module/presentation/controller/service_controller.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/event_slider.dart';
import 'package:sizer/sizer.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';

class ServiceProfileView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType)
    {
      double width = 100.w;
      double height = 100.h;


        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NextButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icons.arrow_back_ios_rounded,
                ),
              )),
          backgroundColor: Colors.grey.shade100,
          body: GetBuilder<ServiceController>(
            builder: (controller) {
              return controller.gettingService
                ? LoadingScreen(width * 0.1)
                : Column(
              children: [
                Expanded(
                  flex: 16,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomCachedNetworkImage(
                                imageUrl: controller.selectedService
                                    .coverUrl,
                                width: width,
                                height: height * 0.4),
                            Container(
                              width: width,
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipOval(
                                      child: Container(
                                          color: Colors.black45,
                                          child: CustomCachedNetworkImage(
                                              imageUrl: controller
                                                  .selectedService.logoUrl,
                                              width: 0.3 * width,
                                              height: 0.3 * width))),
                                ),
                                Text(
                                  controller.selectedService.name,
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .headlineLarge,
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: CustomColors.red.withOpacity(0.5),
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            size: width * 0.08,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            GetBuilder<RegionController>(
                                                builder: (regController) {
                                                  return Text(
                                                    regController.regions
                                                        .where((element) =>
                                                    element.id ==
                                                        controller
                                                            .selectedService
                                                            .regionId)
                                                        .first
                                                        .name,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  );
                                                }),
                                            SizedBox(
                                              width: 0.4 * width,
                                              child: Text(
                                                controller.selectedService
                                                    .address,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                    color:
                                                    Colors.grey.shade400),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(controller.selectedService
                                            .totalRate.toStringAsFixed(1),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.white)),
                                        Icon(
                                          Icons.star,
                                          size: width * 0.08,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.selectedService.about,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                              Divider(thickness: 1),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Our ${controller.selectedService
                                      .itemTitle}",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              controller.selectedService.serviceItems.isEmpty?Text(
                                "No items yet",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: CustomColors.red),
                              ):      SizedBox(
                                height: height * 0.3,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ServiceItemWidget(
                                          serviceItem: controller
                                              .selectedService.serviceItems[index],
                                          width: width * 0.5,
                                          height: height * 0.3,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (index, context) =>
                                        SizedBox(width: width*0.02,),
                                    itemCount: controller.selectedService
                                        .serviceItems.length),
                              ),
                              if(controller.selectedService.gallery.isNotEmpty)       Divider(thickness: 1),
                             if(controller.selectedService.gallery.isNotEmpty) Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Gallery',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  GridView.count(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    physics: NeverScrollableScrollPhysics(),
                                    childAspectRatio: width / (height * 0.7),
                                    children: List.generate(
                                      controller.selectedService.gallery
                                          .length,
                                          (index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, bottom: 8),
                                            child: InkWell(
                                              onTap: () =>
                                                  controller.onTapImage(
                                                      controller
                                                          .selectedService
                                                          .gallery[index],
                                                      context),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                child: CustomCachedNetworkImage(
                                                  imageUrl: controller
                                                      .selectedService
                                                      .gallery[index],
                                                  width: width * 0.4,
                                                  height: height * 0.25,
                                                ),
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 1),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Reviews",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              for (int i = 0; i <
                                  controller.selectedService.rates
                                      .length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProductReviewWidget(
                                    rateModel: controller.selectedService
                                        .rates[i],
                                  ),
                                ),
                              if(controller.selectedService.rates.isEmpty)Text(
                                "No reviews yet",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: CustomColors.red),
                              ),
                              Divider(thickness: 1),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Contact Us',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 0.02 * width),
                                        child: Icon(
                                          Icons.email,
                                          size: width * 0.05,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      InkWell(onTap:
                                          () =>
                                          CustomUrlLauncher.launchEmailApp(
                                              controller.selectedService
                                                  .email),

                                        child: Text(
                                          controller.selectedService.email,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.blueAccent),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                    child: ExpansionPanelList(
                                      expansionCallback:
                                          (int panelIndex, bool isExpanded) =>
                                          controller.onExpand(
                                              panelIndex, isExpanded),
                                      children: [
                                        ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0.02 * width),
                                                    child: Icon(
                                                      Icons.phone,
                                                      size: 0.04 * width,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Phone Contacts',
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          body: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: controller
                                                    .selectedService
                                                    .serviceContacts
                                                    .map((contact) =>
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          bottom: 0.01 * height),
                                                      child: InkWell(onTap:
                                                          () => CustomUrlLauncher
                                                          .launchCallApp(contact),
                                                        child: Text(
                                                          contact,
                                                          style: Theme
                                                              .of(
                                                              context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                      ),
                                                    ))
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          isExpanded: controller
                                              .isExpandedPhone,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomButton(
                            height: height * 0.05,
                            width: 0.5 * width,
                            borderRadius: 0,
                            onPressed: () => controller.showReviewDialog(
                                context, width, height),
                            useGradient: false,
                            circleIcon: false,
                            borderColor: CustomColors.red,
                            icon: Icons.star,
                            label: 'Rate us'),
                        CustomButton(
                            height: height * 0.05,
                            width: 0.5 * width,
                            borderRadius: 0,
                            borderColor: CustomColors.green,
                            onPressed: () =>


                                CustomUrlLauncher.launchWebUrl(controller
                                    .selectedService.websiteUrl),
                            icon: Icons.web,
                            useGradient: false,
                            circleIcon: false,
                            color: CustomColors.green,
                            label: 'Our website')
                      ],
                    ))
              ],
              );
            }
          )
        );

    });
}}
