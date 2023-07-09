import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_init_module/presentation/controller/region_controller.dart';
import '../../../auth_module/presentation/controller/current_user_controller.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../data/model/new_event_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';
import '../../domain/usecase/add_new_event_use_case.dart';

class NewEventController extends GetxController {
  final newEventFormKey = GlobalKey<FormState>();

  removeInstruction(int index) {
    instructionsFormFields.removeAt(index);
    instructionsTextEditingControllers.removeAt(index);
    update();
  }

  addInstruction(BuildContext context) {
    final controller = TextEditingController();
    instructionsTextEditingControllers.add(controller);
    instructionsFormFields.add(CustomTextFormField(
      validator: (value) {
        if (controller.text.isEmpty) {
          return "this field cannot be empty, remove it instead.";
        }
      },
      controller: controller,
      context: context,
      label: '',
      labelColor: Colors.black,
      color: Colors.grey.shade400,
    ));
    update();
  }

  onSelectMembersOnly(bool newValue) {
    onlyMembersCanAttend = newValue;
    update();
  }

  onSelectUnderFive(bool newValue) {
    freeUnder5 = newValue;
    update();
  }

  onSelectLanguage(bool value, int index) {
    final speakingLanguageController = Get.find<AppDataController>();

    value
        ? allowedLanguages
            .add(speakingLanguageController.speakingLanguages[index].id)
        : allowedLanguages
            .remove(speakingLanguageController.speakingLanguages[index].id);
    update();
  }

  addImages() async {
    images.addAll(await ImagePicker().pickMultiImage(imageQuality: 50));
    update();
  }

//new event fields controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventOrganizerPhoneController = TextEditingController();
  TextEditingController eventAddressController = TextEditingController();
  TextEditingController eventAdultTicketPriceController =
      TextEditingController();
  TextEditingController eventReferenceNumberController =
      TextEditingController();
  TextEditingController eventKidTicketPriceController = TextEditingController();
  TextEditingController eventMaxAttendeesController = TextEditingController();
  TextEditingController eventDetailsController = TextEditingController();
  String eventDate = "date";
  String eventTime = "time";
  List<CustomTextFormField> instructionsFormFields = [];
  List<TextEditingController> instructionsTextEditingControllers = [];
  bool onlyMembersCanAttend = false;
  bool freeUnder5 = false;
  Map<CustomTextFormField, String> instructions = {};
  List<int> allowedLanguages = [];
  List<XFile> images = [];

  // Future<void> uploadEventCovers() async {
  //   final fileList = await Future.wait(images.map((e) async {
  //     final file = dio.MultipartFile.fromFile(e.path,
  //         filename: e.name, contentType: MediaType('image', 'jpeg'));
  //     return file;
  //   }));
  //
  //   final formData = dio.FormData.fromMap({
  //     "name": "Annual Charity Walk2",
  //     "appointment": "2023-06-12 10:00:00+00:00",
  //     "phone": "555-1234",
  //     "address": "123 Elm St",
  //     "details": "Help support our local charity by joining us for a 5k walk!",
  //     "ticket_price": 25.99,
  //     "community_id": 1,
  //     "max_attendees": 50,
  //     "members_only": false,
  //     "instructions": [
  //       "Please arrive on time to ensure a prompt start",
  //       "Please keep the venue clean and tidy, and dispose of any rubbish in the appropriate bins",
  //       "Food and drinks are not allowed in the event venue",
  //       "Please do not take photographs or record the event without the consent of the organizers and the speaker",
  //       "If you require any special accommodations, please inform the organizers before the event",
  //       "Have fun and enjoy the event!"
  //     ],
  //     "languages": [1, 2],
  //     'covers': fileList,
  //   });
  //
  //   // Send the FormData object using dio
  //   dio.Dio dio2 = dio.Dio();
  //
  //   dio.Response response = (await dio2.post(
  //     AppConstants.eventsRoute,
  //     data: formData,
  //   ));
  // }

  bool creatingEvent = false;

  createEvent() async {
    if (newEventFormKey.currentState!.validate()) {
      if (instructionsTextEditingControllers.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 instruction",
            successful: false);
      } else if (allowedLanguages.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 allowed language",
            successful: false);
      } else if (eventDate == "date") {
        customSnackBar(
            title: "",
            message: "You did not select event date",
            successful: false);
      } else if (eventTime == "time") {
        customSnackBar(
            title: "",
            message: "You did not select event time",
            successful: false);
      } else if (images.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 image",
            successful: false);
      } else {
        creatingEvent = true;
        update();
        String dateString = '$eventDate $eventTime';
        log(dateString);
        DateTime dateTime =
            DateFormat('MMMM dd, yyyy h:mm a').parse(dateString);
        log('eventDate: $dateTime');
        BaseCommunityRemoteDataSource communityRemoteDataSource =
            CommunityRemoteDataSource();
        BaseCommunityRepository communityRepository =
            CommunityRepository(communityRemoteDataSource);
        final authController = Get.find<CurrentUserController>();

        final result =
            await AddNewEventUseCase(communityRepository).execute(NewEventModel(
          instructions:
              instructionsTextEditingControllers.map((e) => e.text).toList(),
          languages: allowedLanguages,
          images: images,
          communityId: authController.currentUser!.community!.id,
          name: eventNameController.text,
          appointment: dateTime,
          phone: eventOrganizerPhoneController.text,
          address: eventAddressController.text,
          details: eventDetailsController.text,
          adultTicketPrice: double.parse(eventAdultTicketPriceController.text),
          membersOnly: onlyMembersCanAttend,
          maxAttendees: int.parse(eventMaxAttendeesController.text),
          kidTicketPrice: double.parse(eventKidTicketPriceController.text),
          underFiveFree: freeUnder5,
          referenceNumber: eventReferenceNumberController.text,
        ));
        result.fold(
            (l) => customSnackBar(
                title: "error",
                message: l.message.toString(),
                successful: false), (r) {
          customSnackBar(title: "Done", message: r, successful: true);
          Get.offAllNamed('/home');
        });
        creatingEvent = false;
        update();
      }
    }
  }

  removeImage(int index) {
    images.removeAt(index - 1);
    update();
  }
}
