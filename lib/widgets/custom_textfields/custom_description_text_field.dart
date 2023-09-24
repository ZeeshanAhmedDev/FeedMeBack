import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';
import '../../utils/constant.dart';
import '../../utils/string_resource.dart';

TextFormField descriptionTextFormField(
    {required Function(dynamic value) onfieldSubmitted, controllerr}) {
  return TextFormField(
    inputFormatters: [
      Constants.disableEmojiFromTextField,
    ],
    onChanged: onfieldSubmitted,
    maxLines: 10,
    keyboardType: TextInputType.text,
    maxLength: 250,
    controller: controllerr,
    validator: (value) {
      if (value.toString().length <= 19) {
        return StringResource.enterValidSuggestionMessage;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
    cursorColor: Color(AppColor.lightgreen),
    style: TextStyle(fontSize: 17.sp, color: Color(AppColor.lightgreen)),
    decoration: InputDecoration(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        borderSide: BorderSide(
          width: 1.w,
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        borderSide: BorderSide(
          width: 1.w,
          color: Colors.red,
        ),
      ),
      hintText: 'Type Here',
      hintStyle: TextStyle(
          color: Color(0xff9F9F9F),
          textBaseline: TextBaseline.alphabetic,
          fontSize: 17.sp),
      fillColor: Color(AppColor.feildColor),
      filled: true,
      contentPadding: EdgeInsets.only(
        top: 18.h,
        bottom: 18.h,
        left: 27.w,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        borderSide: BorderSide(
          width: 1.w,
          color: Color(0xff308181),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.r),
      ),
    ),
    textAlign: TextAlign.start,
  );
}
