import 'dart:async';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:feedmeback/Services/auth_services.dart';
import 'package:feedmeback/modules/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart' as UniLink;
import '../../../Models/user_model.dart';
import '../../../Provider.dart';
import '../../../config/themes/theme.dart';
import '../../../utils/constant.dart';
import '../../../utils/controllers.dart';
import '../../../utils/helper.dart';
import '../../../utils/string_resource.dart';
import '../../../views/feedback_taker_ID.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/custom_textfields/JustPasswordField/JustPasswordField.dart';
import '../../../widgets/custom_textfields/textFeild.dart';
import 'forgot_password_Screen.dart';
import 'register_user_with_only_email.dart';

UserModel user = UserModel();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  ControllersTextFieldsClass _controllersTextFieldsClass =
      ControllersTextFieldsClass();

  @override
  void dispose() {
    super.dispose();
    _controllersTextFieldsClass.emailLoginController.dispose();
    _controllersTextFieldsClass.passwordLoginController.dispose();
  }

  @override
  void initState() {
    // checkDeepLink();
    Helper.getIndustryNameList.clear();
    Helper.getIndustryIDList.clear();
    super.initState();
  }

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
          child: DoubleBack(
            message: StringResource.pressAgainToClose,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
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
                            height: 23.h,
                          ),
                          Text(
                            StringResource.SignIn,
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
                            StringResource.Email_Address,
                            orientation == Orientation.portrait ? 368.w : 200.w,
                            orientation,
                            validatorr: (value) {
                              if ((!Constants.regExpForEmail.hasMatch(
                                  _controllersTextFieldsClass
                                      .emailLoginController.text))) {
                                return StringResource.enterValidEmailMessage;
                              }
                              return null;
                            },
                            controller: _controllersTextFieldsClass
                                .emailLoginController,
                            maximumLength: 60,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: Constants.focusNodeEmailLogin,
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          SizedBox(
                            width: 0.87.sw,
                            child: JustPasswordField(
                              validatorr: (value) {
                                if (_controllersTextFieldsClass
                                        .passwordLoginController.text.length <=
                                    2) {
                                  return StringResource
                                      .enterValidPasswordMessageIsEmpty;
                                }
                                return null;
                              },
                              controller: _controllersTextFieldsClass
                                  .passwordLoginController,
                              hint: StringResource.Password,
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          colored_Button(
                              orientation,
                              orientation == Orientation.portrait
                                  ? 160.w
                                  : 90.w,
                              StringResource.SignInSmall, () async {
                            if (_formKey.currentState!.validate()) {
                              ///------------- Navigate directly to homePage-------------

                              dynamic res = await ApiClient.login(
                                _controllersTextFieldsClass
                                    .emailLoginController.text,
                                _controllersTextFieldsClass
                                    .passwordLoginController.text,
                                context,
                              );

                              if (res['status']) {
                                user = UserModel.fromJson(res);
                                Provider.of<DataProviders>(context,
                                        listen: false)
                                    .updateUserObject(user);

                                SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                _prefs.setString('token', res['data']['token']);

                                print("Token ==> ${res['data']['token']}");
                                Helper.FeedBackTakerIdList.clear();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TakeFeedbackIDScreen()));
                              } else
                                Helper.ToastMessage(
                                    context: context,
                                    descMessage:
                                        '${res['data'].toString().replaceAll('[', '').replaceAll(']', '')}');
                            }
                          }),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? 27.h
                                : 60.h,
                          ),
                          orientation == Orientation.portrait
                              ? columnWidget(context)
                              : rowWidget(context)
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

Widget rowWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        children: [
          Text(StringResource.DoNot_Have_an_Account,
              style: TextStyle(fontSize: 30.sp)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              }),
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Text(
                  StringResource.SignUp,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 30.sp,
                    color: Color(AppColor.lightgreen),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 30.w,
      ),
      Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => forgotScreen(),
                    ));
              }),
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Text(
                  StringResource.forgotPassword,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(AppColor.lightgreen),
                    fontSize: 30.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

Widget columnWidget(BuildContext context) {
  return Column(
    children: [
      Text(StringResource.DoNot_Have_an_Account,
          style: TextStyle(fontSize: 17.sp)),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  // builder: (context) => SignUpScreen(),
                  builder: (context) => RegisterUserOnlyWithEmailScreen(),
                ));
          }),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(StringResource.SignUp,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 19.sp,
                    color: Color(AppColor.lightgreen))),
          ),
        ),
      ),
      SizedBox(
        height: 100.h,
      ),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => forgotScreen(),
              ),
            );
          }),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(
              StringResource.forgotPassword,
              // user.data!.user!.email.toString(),
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(AppColor.lightgreen),
                fontSize: 18.h,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

/*Future checkDeepLink() async {
  StreamSubscription _sub;
  try {
    final prefs = await SharedPreferences.getInstance();

    print("checkDeepLink");
    await UniLink.getInitialLink();
    _sub = UniLink.uriLinkStream.listen((Uri? uri) {
      print(uri);

      Helper.uriTaker = uri;

      var get = Helper.uriTaker!.path
          .replaceAll('https://fmb-front.digitaezonline.com/signup/', "");
      get = get.replaceAll('/signup/', '');
      print("------Get String------------> " + get);
      prefs.setString('CODE', get);

      emailVerifications();
    }, onError: (err) {
      print("onError");
    });
    _sub.cancel();
  } on PlatformException {
    print("PlatformException");
  }
}

Future<void> emailVerifications() async {
  dynamic res = await ApiClient.emailVerification();

  if (res['status'] == true) {
    Get.to(() => SignUpScreen());
    print(
        'Email Verified----------------------------------------------------> ' +
            res.toString());
  } else {
    Get.to(() => RegisterUserOnlyWithEmailScreen());
    print('Email NOT----------------------------------------------------> ' +
        res.toString());
  }
}*/
