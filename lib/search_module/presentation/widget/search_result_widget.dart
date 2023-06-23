import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/search_module/domain/entity/search_result_entity.dart';
import 'package:imperial/service_module/presentation/controller/service_controller.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';

class SearchResultWidget extends StatelessWidget {
  double width, height, iconSize;

  SearchResultWidget(
      {required this.width, required this.height, required this.searchResult, required this.iconSize});

  SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    return Container(height: height,
      width: width,
      child: ClipRRect(borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            CustomCachedNetworkImage(
                imageUrl: searchResult.cover, width: width, height: height),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(alignment: Alignment.center,
                      child: Container(padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.black54,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          searchResult.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.amber),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  searchResult.about, maxLines: 4,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ),
                            ),
                            Expanded(flex: 1,
                              child: CustomButton(
                                  height: height * 0.15,
                                  width: width * 0.1,
                                  onPressed: () {
                                    switch (searchResult.type){
                                    case "community":
                                    {
                                    final C=Get.find<CommunityController>();
                                    C.getCommunity(searchResult.id);
                                    }
                                    break;
                                    case "event":
                                    {
                                    final C=Get.find<EventController>();
                                    C.getEvent(searchResult.id);
                                    }
                                    break;
                                    case "service":
                                    {
                                    final C=Get.find<ServiceController>();
                                    C.onSelectService(searchResult.id);
                                    }
                                    break;
                                    }
                                  },
                                  label: "Visit"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.amber,
                              size: (iconSize) * width,
                            ),
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                  searchResult.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
