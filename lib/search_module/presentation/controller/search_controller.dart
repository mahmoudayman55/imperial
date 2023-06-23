import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/search_module/data/data_source/search_remote_data_source.dart';
import 'package:imperial/search_module/data/repo/search_repo.dart';
import 'package:imperial/search_module/domain/entity/search_result_entity.dart';
import 'package:imperial/search_module/domain/usecase/SearchUseCase.dart';
import 'dart:developer';

import 'package:imperial/search_module/presentation/view/search_results_view.dart';

import '../../../widgets/custom_snack_bar.dart';
class HomeSearchController extends GetxController{
  late RxList<SearchResult> communitiesSearchResults;
  late RxList<SearchResult> eventsSearchResults;
  late RxList<SearchResult> servicesSearchResults;
  TextEditingController searchController=TextEditingController();
  RxBool searching=false.obs;

search()async{
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    customSnackBar(
      title: "error",
      message: "No internet connection",
      successful: false,
    );
    return;
  }
  searching.value=true;
  searching.refresh();
  Get.to(SearchResultsView());
  communitiesSearchResults=<SearchResult>[].obs;
  eventsSearchResults=<SearchResult>[].obs;
  servicesSearchResults=<SearchResult>[].obs;
  final result=await SearchUseCase(SearchRepo(SearchRemoteDataSource())).execute(searchController.text);
  result.fold((l) {
   log(l.message.toString());
  }, (r) {
  for (var result in r) {
    switch (result.type){
      case "community": communitiesSearchResults.add(result);
      break;
      case "event": eventsSearchResults.add(result);
      break;
      case "service": servicesSearchResults.add(result);
      break;
    }


  }
  }

  );
  searching.value=false;
  searching.refresh();
}reSearch()async{
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    customSnackBar(
      title: "error",
      message: "No internet connection",
      successful: false,
    );
    return;
  }
  searching.value=true;
  searching.refresh();
  communitiesSearchResults=<SearchResult>[].obs;
  eventsSearchResults=<SearchResult>[].obs;
  servicesSearchResults=<SearchResult>[].obs;
  final result=await SearchUseCase(SearchRepo(SearchRemoteDataSource())).execute(searchController.text);
  result.fold((l) =>    log(l.message.toString())
      , (r) {
  for (var result in r) {
    log("message");
    switch (result.type){
      case "community": communitiesSearchResults.add(result);
      break;
      case "event": eventsSearchResults.add(result);
      break;
      case "service": servicesSearchResults.add(result);
      break;
    }


  }});    searching.value=false;
  searching.refresh();
}
  @override
  void onInit() {
    communitiesSearchResults=<SearchResult>[].obs;
    eventsSearchResults=<SearchResult>[].obs;
    servicesSearchResults=<SearchResult>[].obs;
  log("Search:");

  }
}