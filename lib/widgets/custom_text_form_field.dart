import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/custom_colors.dart';

class CustomTextFormField extends FormField<String> {
  CustomTextFormField({
    Key? key,
    String? initialValue,
    required context,
    FormFieldSetter<String>? onSaved,
    String? Function(String? val)? validator,
    bool? autovalidate,
    Color textColor = Colors.black,
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    bool? autofocus,
    bool? enabled,
    bool isPassword = false,
    IconData? suffixIcon,
    int? maxLength,
    Color color = Colors.white,
    Color labelColor = Colors.white,
    required String label,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted, int maxLines=1
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<String> state) {
            return Sizer(builder: (context, orientation, deviceType) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(maxLines: maxLines,
                      controller: controller,
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      focusNode: focusNode,
                      autofocus: autofocus ?? false,
                      enabled: enabled ?? true,
                      maxLength: maxLength,
                      maxLengthEnforcement:
                          maxLengthEnforcement ?? MaxLengthEnforcement.enforced,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: textColor),
                      decoration: InputDecoration(errorStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color:CustomColors.red),
                          border: InputBorder.none,
                          hintText: label,
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[400]),
                          suffixIcon: Icon(suffixIcon)),
                      onChanged: onChanged,
                      onEditingComplete: onEditingComplete,
                      onFieldSubmitted: onFieldSubmitted,
                    ),
                  ),
                  if (state.hasError) // display the error message below the TextFormField
                    Text(
                      state.errorText!,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color:Colors.red),
                    ),
                ],
              );
            });
          },
        );
}
