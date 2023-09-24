import 'package:feedmeback/modules/auth/screens/signin_screen.dart';
import 'package:feedmeback/utils/constant.dart';
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
import '../../../utils/string_resource.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/custom_textfields/textFeild.dart';
import 'email_send_screen.dart';

class forgotScreen extends StatefulWidget {
  const forgotScreen({Key? key}) : super(key: key);

  @override
  State<forgotScreen> createState() => _forgotScreenState();
}

class _forgotScreenState extends State<forgotScreen> {
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

  ControllersTextFieldsClass _controllersTextFieldsClass =
      ControllersTextFieldsClass();
  @override
  void dispose() {
    _controllersTextFieldsClass.emailForgotPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
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
                            height: 40.h,
                          ),
                          Text(
                            StringResource.forgotPassword.replaceAll("?", ""),
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 25.sp
                                    : 30.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(StringResource.enterYourEmailForgotText1,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 17.sp
                                      : 30.sp)),
                          Text(StringResource.enterYourEmailForgotText2,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 17.sp
                                      : 30.sp)),
                          SizedBox(
                            height: 20.h,
                          ),
                          textField(
                            StringResource.Email_Address,
                            orientation == Orientation.portrait ? 368.w : 200.w,
                            orientation,
                            validatorr: (value) {
                              if ((!Constants.regExpForEmail.hasMatch(
                                  _controllersTextFieldsClass
                                      .emailForgotPassController.text))) {
                                return StringResource.enterValidEmailMessage;
                              }

                              return null;
                            },
                            controller: _controllersTextFieldsClass
                                .emailForgotPassController,
                            maximumLength: 60,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          colored_Button(
                              orientation,
                              orientation == Orientation.portrait
                                  ? 160.w
                                  : 90.w,
                              StringResource.sendEmailBtnTxt, () async {
                            if (_formKey.currentState!.validate()) {
                              /// ---------------------------------------------------------

                              dynamic res = await ApiClient.forgotPassword(
                                _controllersTextFieldsClass
                                    .emailForgotPassController.text,
                                context,
                              );

                              if (res['status']) {
                                print("${res['data']}");

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const emailScreen()));
                              } else
                                Helper.ToastMessage(
                                    context: context,
                                    descMessage:
                                        '${res['data'][0]['email'].toString().replaceAll('[', '').replaceAll(']', '')}');
                            }
                          }),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? 27.h
                                : 60.h,
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? 150.h
                                : 10.h,
                          ),
                          Text(StringResource.Already_Have_an_Account,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 17.sp
                                      : 30.sp)),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: (() {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                }),
                                child: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: Text(StringResource.SignIn,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(AppColor.lightgreen),
                                          fontSize: orientation ==
                                                  Orientation.portrait
                                              ? 18.sp
                                              : 30.sp)),
                                )),
                          ),
                        ],
                      )
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
