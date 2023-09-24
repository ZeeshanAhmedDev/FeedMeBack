import 'dart:developer';
import 'package:feedmeback/modules/auth/screens/signin_screen.dart';
import 'package:feedmeback/modules/auth/screens/wait_screen.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:feedmeback/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../Provider.dart';
import '../../../Services/auth_services.dart';
import '../../../config/themes/theme.dart';
import '../../../utils/controllers.dart';
import '../../../utils/helper.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/custom_textfields/textFeild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var getIDOfIndustry;

  //===================================Start
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
      return Future.value(false);
    }
    return Future.value(true);
  }
  //===================================END

  final _formKey = GlobalKey<FormState>();
  ControllersTextFieldsClass _controllersTextFieldsClass =
      ControllersTextFieldsClass();

  var _chosenValue;

  @override
  void initState() {
/*    getIndustries(context);*/
    super.initState();
    getIndustries(context);
  }

  @override
  void didChangeDependencies() {
    // getIndustries(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllersTextFieldsClass.nameSignUpController.dispose();
    _controllersTextFieldsClass.organizationSignUpNameController.dispose();
    _controllersTextFieldsClass.contactNoSignUpController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<DataProviders>(context).showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Color(AppColor.lightgreen),
          ),
          child: WillPopScope(
            onWillPop: () => onWillPop(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Container(
                  height: orientation == Orientation.portrait ? 1.sh : 1.25.sh,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? 90.h
                                  : 20.h,
                            ),
                            SvgPicture.asset(
                              Constants.kMainLogoSvg,
                              fit: BoxFit.contain,
                              width: orientation == Orientation.portrait
                                  ? 182.w
                                  : 210.w,
                              height: orientation == Orientation.portrait
                                  ? 182.h
                                  : 210.h,
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 25.sp
                                      : 30.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            textField(
                              "Name",
                              orientation == Orientation.portrait
                                  ? 368.w
                                  : 200.w,
                              orientation,
                              validatorr: (value) {
                                if (value.toString().trim().length <= 2) {
                                  return StringResource.enterValidNameMessage;
                                } else if ((!Constants
                                    .regExpForOnlyAlphabetsWithGapAndHyphen
                                    .hasMatch(_controllersTextFieldsClass
                                        .nameSignUpController.text))) {
                                  return StringResource
                                      .enterValidOnlyAlphabetsMessage;
                                }
                                return null;
                              },
                              controller: _controllersTextFieldsClass
                                  .nameSignUpController,
                              maximumLength: 30,
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            textField(
                              "Organization Name",
                              orientation == Orientation.portrait
                                  ? 368.w
                                  : 200.w,
                              orientation,
                              validatorr: (value) {
                                if (value.toString().trim().length <= 2) {
                                  return StringResource
                                      .enterValidOrganizationNameMessage;
                                } else if ((!Constants
                                    .regExpForOnlyAlphabetsWithGapAndHyphen
                                    .hasMatch(_controllersTextFieldsClass
                                        .organizationSignUpNameController
                                        .text))) {
                                  return StringResource
                                      .enterValidOnlyAlphabetsMessage;
                                }

                                return null;
                              },
                              controller: _controllersTextFieldsClass
                                  .organizationSignUpNameController,
                              maximumLength: 60,
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            textField(
                              "Contact Number",
                              orientation == Orientation.portrait
                                  ? 368.w
                                  : 200.w,
                              orientation,
                              validatorr: (value) {
                                /*  if (((!Constants.regExpForMobileNumber.hasMatch(
                                    _controllersTextFieldsClass
                                        .contactNoSignUpController.text)))) {
                                  return StringResource
                                      .enterValidContactNumberMessage;
                                }*/

                                if (_controllersTextFieldsClass
                                    .contactNoSignUpController.text
                                    .toString()
                                    .isEmpty) {
                                  return StringResource
                                      .enterValidContactNumberMessage;
                                }
                                return null;
                              },
                              controller: _controllersTextFieldsClass
                                  .contactNoSignUpController,
                              keyboardType: TextInputType.number,
                              maximumLength: 11,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            ///dropDown
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(AppColor
                                      .lightgreen), // red as border color
                                ),
                                color: Color(AppColor.lightgreen)
                                    .withOpacity(0.06),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              width: 368.w,

                              // padding: const EdgeInsets.all(0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 20.0.w),

                                    // helperText: 'ss',
                                    // errorStyle: TextStyle(fontSize: 4),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    // isDense: true,
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Industry cannot be empty';
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
                                  value: _chosenValue,
                                  style: TextStyle(
                                      // fontWeight: FontWeight.w500,
                                      color: Color(
                                    AppColor.lightgreen,
                                  )),
                                  items: Helper.getIndustryNameList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          Helper.getIndustryNameList.isNotEmpty
                                              ? value
                                              : null,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 27.w),
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: Color(AppColor.lightgreen),
                                              fontSize: 17.sp),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      "Industry",
                                      style: TextStyle(
                                          color: Color(AppColor.lightgreen),
                                          fontSize: 17.sp),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenValue = value;
                                      int index = Helper.getIndustryNameList
                                          .indexOf(_chosenValue)
                                          .toInt();
                                      log("Id of user ${Helper.getIndustryIDList[index]}");
                                      getIDOfIndustry =
                                          Helper.getIndustryIDList[index];

                                      //
                                    });
                                  },
                                ),
                              ),
                            ),

                            ///dropDown

                            SizedBox(
                              height: 24.h,
                            ),
                            colored_Button(
                                orientation,
                                orientation == Orientation.portrait
                                    ? 160.w
                                    : 90.w,
                                "Sign up", () async {
                              if (_formKey.currentState!.validate() &&
                                  _chosenValue != null) {
                                final name = _controllersTextFieldsClass
                                    .nameSignUpController.text;
                                final brandName = _controllersTextFieldsClass
                                    .organizationSignUpNameController.text;
                                final phoneNumber = _controllersTextFieldsClass
                                    .contactNoSignUpController.text;

                                // ---------------------------------------
                                final industryID = getIDOfIndustry;
                                final userID = 8;
                                final deviceKey = 38;

                                dynamic res = await ApiClient.SignUp(
                                  name,
                                  brandName,
                                  phoneNumber,
                                  industryID,
                                  userID,
                                  deviceKey,
                                  context,
                                );

                                if (res['status']) {
                                  print('------> $res');
                                  print('--industryID----> $industryID');
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const waitScreen()));
                                } else
                                  Helper.ToastMessage(
                                      context: context,
                                      descMessage:
                                          '${res['data'][0]['device_key'].toString().replaceAll('[', '').replaceAll(']', '')}');
                                print('--industryID----> $industryID');
                              }
                            }),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? 27.h
                                  : 60.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              child: Text(
                                "Already Have an account?",
                                // "$showData",
                                style: TextStyle(
                                    fontSize:
                                        orientation == Orientation.portrait
                                            ? 17.sp
                                            : 30.sp),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (() {
                                  // Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInScreen(),
                                      ));
                                }),
                                child: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: Text(
                                    "Sign In?",
                                    style: TextStyle(
                                        color: Color(AppColor.lightgreen),
                                        decoration: TextDecoration.underline,
                                        fontSize:
                                            orientation == Orientation.portrait
                                                ? 18.sp
                                                : 30.sp),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Future<void> getIndustries(BuildContext context) async {
  dynamic res = await ApiClient.getIndustriesIds(context);

  if (res['status'] == true) {
    print(
        'getIndustries----------------------------------------------------> ' +
            res.toString());
    res['data'].forEach((value) {
      print("Industry Name----------> " + value['name'].toString());
      print("Industry ID ----------> " + value['id'].toString());

      Helper.getIndustryNameList.add(value['name']);
      Helper.getIndustryIDList.add(value['id']);
    });
  }
}
