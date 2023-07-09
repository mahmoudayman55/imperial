import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/service_register_controller.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../app_init_module/presentation/controller/region_controller.dart';
import '../../../../core/utils/custom_colors.dart';
import '../../../../core/utils/uk_number_validator.dart';
import '../../../../view/loading_screen.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../controller/user_join_requests_controller.dart';




class BusinessRegistrationView extends StatelessWidget {
  final regionController=Get.find<AppDataController>();


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;

      return deviceType==DeviceType.mobile? Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title:
        Text("Service registration",style: Theme.of(context).textTheme.headlineLarge,),centerTitle: true,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NextButton(
                iconSize: 5,
                onPressed: () {Get.back();},
                icon: Icons.arrow_back_ios_rounded,
              ),
            )),
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/authbg.jpg',
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: height ,
                  padding: EdgeInsets.all(10),
                  child: GetBuilder<ServiceRegisterController>(
                      builder: (controller) {
                        return regionController.regions.isEmpty?LoadingScreen(width * 0.1): Form(
                          key: controller.registerServiceFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.ownerNameController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.ownerNameController,
                                  context: context,
                                  label: 'User Name',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.nameController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.nameController,
                                  context: context,
                                  label: 'Service Name',
                                ),
                              ),           Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.addressController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.addressController,
                                  context: context,
                                  label: 'Address',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child:    CustomTextFormField(keyboardType: TextInputType.emailAddress,
                                  controller:
                                  controller.emailController,
                                  validator: (value) {

                                    if ( controller.emailController.text.isEmpty ||
                                        !EmailValidator.validate(controller.emailController.text )) {
                                      return "Invalid email address";
                                    }
                                    return null;
                                  },
                                  context: context,
                                  label: "Email",
                                  textColor: Colors.white,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Container(alignment: Alignment.topCenter,
                                        height: height*0.06,
                                        child: Text(
                                          "+44",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 10,
                                      child: CustomTextFormField(keyboardType: TextInputType.phone,
                                        controller:controller
                                            .phoneController,
                                        context: context,
                                        label: "phone",
                               textColor: Colors.white,
                                        validator: (v) {
                                          if (!isUkPhoneNumber(
                                              "+44${controller
                                                  .phoneController
                                                  .text}")) {
                                            return "invalid phone number";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    label: 'Region',
                                    items: regionController.regions,initialValue: regionController.regions[0],
                                    onChanged: (item) {
                                      controller.onRegionChanged(item);
                                    }),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  textColor: Colors.white,
                                  controller: controller.websiteController,
                                  context: context,
                                  label: 'Web URL (optional)'
                                ),
                              ),    Expanded(
                                flex: 3,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.aboutController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.aboutController,
                                  context: context,
                                  label: 'About your service',maxLines: 4,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomButton(iconSize: 0.03,
                                  height: height * 0.06,
                                  width: width,enabled: !controller.registeringService,
                                  onPressed:  () {
                                    controller.sendServiceRegistrationRequest();
                                  },
                                  label: controller.registeringService?"Loading...":'Finish',
                                  color: CustomColors.green,
                                  icon: Icons.done,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      ):



     SizedBox();
      ///Todo:tablet
    });
  }
}
