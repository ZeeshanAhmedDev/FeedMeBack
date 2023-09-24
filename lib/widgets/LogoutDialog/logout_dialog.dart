import 'package:feedmeback/modules/customer/Screens/feedback_space.dart';
import 'package:feedmeback/modules/welcome/Screens/welcome_screen.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/string_resource.dart';
import '../Buttons/YesOrNoCustomContainerButton.dart';
import '../Glassmorphism Dialog/glassmorphismdialog.dart';

class GlassMorphismDialog {
  static final _style = TextStyle(
    fontSize: 24.21.sp,
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.bold,
    color: Constants.kWhiteColor,
  );
  static showPromptForLogout(BuildContext context) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.r),
            ),
            child: GlassMorphism(
              blur: 100,
              opacity: 0.1,
              child: SizedBox(
                height: 273.h,
                width: 273.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 36.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Are you sure you',
                          style: _style,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'want to restart?',
                          style: _style,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///--------- YES BUTTON -----------

                    CustomYesOrNoButton(
                      btnText: StringResource.yesButton,
                      textColour: Constants.kWhiteColor,
                      onTapFunc: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => welcomeView()),
                            (Route<dynamic> route) => false);
                      },
                      myGradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffFF4646),
                          Color(0xffFF4646),
                        ],
                      ),
                      myHeight: 50.h,
                      myWidth: 184.w,
                      boxShadow: BoxShadow(
                        color: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///--------- NO BUTTON -----------
                    CustomYesOrNoButton(
                      btnText: StringResource.noButton,
                      textColour: Color(0xffFF4646),
                      onTapFunc: () {
                        Navigator.pop(context);
                      },
                      myGradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffFFFFFF),
                          Color(0xffFFFFFF),
                        ],
                      ),
                      myHeight: 50.h,
                      myWidth: 184.w,
                      boxShadow: BoxShadow(
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showPromptForTogoBackToFeedBackId(BuildContext context) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
          child: GlassMorphism(
            blur: 100,
            opacity: 0.1,
            child: SizedBox(
              height: 273.h,
              width: 273.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Are you sure you',
                        style: _style,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'want to Quit?',
                        style: _style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///--------- YES BUTTON -----------

                  CustomYesOrNoButton(
                    btnText: StringResource.yesButton,
                    textColour: Constants.kWhiteColor,
                    onTapFunc: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => FeedbackSpaceScreen()),
                          (Route<dynamic> route) => false);
                    },
                    myGradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffFF4646),
                        Color(0xffFF4646),
                      ],
                    ),
                    myHeight: 50.h,
                    myWidth: 184.w,
                    boxShadow: BoxShadow(
                      color: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  ///--------- NO BUTTON -----------
                  CustomYesOrNoButton(
                    btnText: StringResource.noButton,
                    textColour: Color(0xffFF4646),
                    onTapFunc: () {
                      Navigator.pop(context);
                    },
                    myGradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffFFFFFF),
                        Color(0xffFFFFFF),
                      ],
                    ),
                    myHeight: 50.h,
                    myWidth: 184.w,
                    boxShadow: BoxShadow(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
