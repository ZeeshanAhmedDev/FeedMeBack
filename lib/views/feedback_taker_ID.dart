import 'dart:developer';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:feedmeback/Provider.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/themes/theme.dart';
import '../../../utils/controllers.dart';
import '../../../utils/string_resource.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/custom_textfields/textFeild.dart';
import '../Services/auth_services.dart';
import '../modules/customer/Screens/feedback_space.dart';
import '../utils/helper.dart';

gotoScreen(BuildContext context, {required dynamic className}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => className));
}

class TakeFeedbackIDScreen extends StatefulWidget {
  const TakeFeedbackIDScreen({Key? key}) : super(key: key);

  @override
  State<TakeFeedbackIDScreen> createState() => _TakeFeedbackIDScreenState();
}

class _TakeFeedbackIDScreenState extends State<TakeFeedbackIDScreen> {
  @override
  void initState() {
    getBrand(context);

    Helper.FeedBackIDForDropDown.clear();
    Helper.FeedBackTakerIdList.clear();
    Helper.userID.clear();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      getFeedBackTakerIds(context);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return DoubleBack(
        message: StringResource.pressAgainToClose,
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<DataProviders>(context).showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Color(AppColor.lightgreen),
          ),
          child: Scaffold(
              body: orientation == Orientation.portrait
                  ? potraitView(orientation, context)
                  : lanscapeView(orientation, context)),
        ),
      );
    });
  }
}

Widget potraitView(Orientation orientation, BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  return Form(
      key: _formKey,
      child: Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200.h),
              SvgPicture.asset(
                Constants.kCustomerRoundImage,
                height: 230.h,
                width: 233.w,
              ),
              SizedBox(height: 30.h),
              Text(StringResource.FeedbackTakerID,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp)),
              SizedBox(height: 5.h),
              Text(
                StringResource.subtitlesOfTFeedbackTakerID,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(AppColor.lightgreen), // red as border color
                  ),
                  color: Color(AppColor.lightgreen).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                width: 231.w,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(left: 20.0.w),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return StringResource.enterFeedbackIDValidation;
                      }
                      return null;
                    },
                    icon: Padding(
                      padding: EdgeInsets.only(right: 18.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(AppColor.lightgreen),
                      ),
                    ),
                    isExpanded: true,
                    value: Provider.of<DataProviders>(context).dropdownValue,
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      color: Color(
                        AppColor.lightgreen,
                      ),
                    ),
                    items: Helper.FeedBackTakerIdList.map<
                        DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27.w),
                          child: Text(
                            value!,
                            style: TextStyle(
                                color: Color(AppColor.lightgreen),
                                fontSize: 17.sp),
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Padding(
                      padding: EdgeInsets.only(left: 27.w),
                      child: Text(
                        StringResource.enterFeedbackID,
                        style: TextStyle(
                            color: Color(AppColor.lightgreen), fontSize: 17.sp),
                      ),
                    ),
                    onChanged: (String? value) async {
                      Provider.of<DataProviders>(context, listen: false)
                          .changeDropdownValue(value!);
                      int index =
                          Helper.FeedBackTakerIdList.indexOf(value).toInt();
                      log("Id of user " + Helper.userID[index].toString());
                      //
                      final pref = await SharedPreferences.getInstance();
                      pref.setString('FeedbackID', '${Helper.userID[index]}');
                    },
                  ),
                ),
              ),
              SizedBox(height: 190.h),
              colored_Button(orientation, 368.w,
                  StringResource.takeFeedbackTextForTFeedbackTakerID, () async {
                if (_formKey.currentState!.validate()) {
                  ///------------- Navigate directly to homePage-------------

                  gotoScreen(
                    context,
                    className: FeedbackSpaceScreen(),
                  );
                }
              })
            ],
          ),
        ),
      ));
}

Future<void> getBrand(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  dynamic res = await ApiClient.getBrand(context);

  if (res['status']) {
    prefs.setInt('brandID', res['data'][0]['id']);
    Helper.getBrandID = prefs.getInt('brandID');
    print(
        'GetBrand----------------------------------------------------> ---> ' +
            res.toString());

    log("this is brand ID in varaible =========================== ${Helper.getBrandID}");
  } else
    print('GetBrand-ER0RR--> ' + res);
}

Future<void> getFeedBackTakerIds(BuildContext context) async {
  dynamic res = await ApiClient.getFeedBackTakerIds(context);

  if (res['status']) {
    print(
        'getFeedBackTakerIds----------------------------------------------------> ' +
            res.toString());
    res['data'].forEach((value) {
      Helper.FeedBackTakerIdList.add(value['taker_id']);
      Helper.userID.add(value['id']);
    });
  }
}

Widget lanscapeView(Orientation orientation, BuildContext context) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 100.h),
          SvgPicture.asset(
            Constants.kCustomerRoundImage,
            height: 250.h,
            width: 253.w,
          ),
          SizedBox(height: 30.h),
          Text(StringResource.tableID,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40.sp)),
          SizedBox(height: 10.h),
          Text(
            StringResource.subtitlesOfTableID,
            style: TextStyle(fontSize: 28.sp),
          ),
          SizedBox(height: 20.h),
          textField(
            StringResource.tableIDTextFieldHint,
            231.w,
            orientation,
            isCenter: true,
            validatorr: (value) {
              if (value.isNotEmpty) {
                return StringResource.enterValidEmailMessage;
              }
              return null;
            },
            controller: ControllersTextFieldsClass().tableIdController,
            maximumLength: 6,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 100.h),
          colored_Button(orientation, 368.w, StringResource.takeFeedbackText,
              () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => FeedbackSpaceScreen()));
          })
        ],
      ),
    ),
  );
}
