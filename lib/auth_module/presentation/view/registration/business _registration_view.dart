import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

import '../../../../core/utils/custom_colors.dart';
import '../../../../core/utils/uk_number_validator.dart';
import '../../../../view/loading_screen.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../controller/auth_controller.dart';


class BusinessRegistrationView extends StatefulWidget {
  @override
  State<BusinessRegistrationView> createState() =>
      _BusinessRegistrationViewState();
}

class _BusinessRegistrationViewState extends State<BusinessRegistrationView> {
  List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String selectedItem = 'Option 1';

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
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
                  child: GetBuilder<AuthController>(
                      builder: (controller) {
                        return controller.gettingServiceRegions?LoadingScreen(width * 0.1): Form(
                          key: controller.registerServiceFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.serviceOwnerNameController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.serviceOwnerNameController,
                                  context: context,
                                  label: 'User Name',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.serviceNameController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.serviceNameController,
                                  context: context,
                                  label: 'Service Name',
                                ),
                              ),           Expanded(
                                flex: 2,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.serviceAddressController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.serviceAddressController,
                                  context: context,
                                  label: 'Address',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child:    CustomTextFormField(keyboardType: TextInputType.emailAddress,
                                  controller:
                                  controller.serviceEmailController,
                                  validator: (value) {

                                    if ( controller.serviceEmailController.text.isEmpty ||
                                        !EmailValidator.validate(controller.serviceEmailController.text )) {
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
                                            .servicePhoneController,
                                        context: context,
                                        label: "phone",
                               textColor: Colors.white,
                                        validator: (v) {
                                          if (!isUkPhoneNumber(
                                              "+44${controller
                                                  .servicePhoneController
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
                                    items: controller.regions,
                                    onChanged: (item) {
                                      controller.onServiceRegionChanged(item);
                                    }),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  textColor: Colors.white,
                                  controller: controller.serviceWebsiteController,
                                  context: context,
                                  label: 'Web URL (optional)'
                                ),
                              ),    Expanded(
                                flex: 3,
                                child: CustomTextFormField( validator: (v){
                                  if(controller.serviceAboutController.text.isEmpty){
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                  textColor: Colors.white,
                                  controller: controller.serviceAboutController,
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
      ):Scaffold(
        extendBodyBehindAppBar: true,
        appBar:  AppBar(
            leadingWidth: 8.w,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: NextButton(
                iconSize: 3,
                onPressed: () {},
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
            Center(
              child: SingleChildScrollView(
                child: Container(width: width*0.6,
                  height: height * 0.9,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          context: context,
                          label: 'Full Name',
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          context: context,
                          label: 'Business Name',
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          context: context,
                          label: 'Email',
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),                SizedBox(height: Get.height*0.01),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InternationalPhoneNumberInput(
                                selectorTextStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: Colors.black54),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                                inputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                onInputChanged: (PhoneNumber value) {},
                                selectorButtonOnErrorPadding: 8,
                                selectorConfig: SelectorConfig(
                                    trailingSpace: false,
                                    selectorType:
                                    PhoneInputSelectorType.DROPDOWN),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Category',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ), SizedBox(height: Get.height*0.01),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  iconEnabledColor: Colors.black,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.white),
                                  value: selectedItem,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItem = newValue!;
                                    });
                                  },
                                  items: items.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Region',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ), SizedBox(height: Get.height*0.01),
                            CustomButton(
                              height: height * 0.06,
                              width: width,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SizedBox(
                                        height: height * 0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 10,
                                                child: RegionSelector()),
                                            Expanded(
                                              flex: 1,
                                              child: CustomButton(
                                                height: height * 0.06,
                                                width: width * 0.8,
                                                label: "Select",
                                                onPressed: () {},
                                                useGradient: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },                              label: 'West Midland',

                              color: Colors.white,
                              textColor: Colors.black,
                              useGradient: false,
                              icon: Icons.done,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          context: context,
                          label: 'About Your Service',
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          height: height * 0.06,
                          width: width,
                          onPressed: () {},
                          label: 'Finish',
                          color: CustomColors.green,
                          icon: Icons.done,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
