import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  ///================================ Email Regex Start ================================

  static final RegExp regExpForEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  ///================================ Email Regex END ==================================

  ///================================ Password Regex END ==================================
  RegExp regExpForPassword = new RegExp(

      ///new regex Latest
      r'^(?=.*[0-9])(?=.*[!@#$%^&*.,+=_-])[a-zA-Z0-9!@#$%^&*.,+=_-]{8,32}$');
  //
  static final RegExp regExpForOnlyAlphabetsWithGapAndHyphen =
      new RegExp(r'^[a-zA-Z-][a-zA-Z -]*$');

  ///================================ Password Regex END ==================================
  ///
  ///================================ Only Number and Alphabets Regex END ==================================
  static final regExpForOnlyAlphabetsAndNumbers = RegExp(r'^[a-zA-Z0-9]*$');
  static final regExpForOnlyAlphabets = RegExp(r'^[a-zA-Z]*$');

  ///================================ Only Number and Alphabets Regex END ==================================

  static final RegExp regExpForMobileNumber =
      RegExp(r"^((0))(3)([0-9]{2})-(-?)([0-9]{7})$");

  static var disableEmojiFromTextField = FilteringTextInputFormatter.deny(RegExp(
      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));

  ///
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kBlueColor = Colors.blue;
  static const kRedColor = Colors.red;
  static const kTextColour = Color(0xff004D4D);
  static const kStepperColor = Color(0xff67C081);
  static const kTransparentColor = Colors.transparent;
  static const kRatingsColor = Color(0xffFFB93E);
  static const kLightGreyColor = Color(0xff747474);

  ///------ color for reactions-------------------------------
  static const kAngryColor = Color(0xffD01515);
  static const kNotOtherEmojiColor = Color(0xffFF9852);

  ///------ color for reactions-------------------------------

  /// app Dimentions
  static final double widthDimension = 428;
  static final double heightDimension = 926;

  ///  assets picture
  static const kMainLogoSvg = 'assets/images/logo.svg';
  static const kArrowImageSvg = 'assets/images/arrow.svg';

  /// login Focus node
  static final focusNodeEmailLogin = FocusNode();
  static final focusNodePasswordLogin = FocusNode();

  //splashScreen Gif
  static final kSplashScreenGifFile = 'assets/images/splash.gif';
  //onBoardingPictures
  static final kOnBoardingImage1 = 'assets/images/image1.svg';
  static final kOnBoardingImage2 = 'assets/images/image2.svg';
  static final kOnBoardingImage3 = 'assets/images/image3.svg';

  //bar of OnBoarding
  static final kRectangleBar1 = 'assets/images/rectangle1.svg';
  static final kRectangleBar2 = 'assets/images/rectangle2.svg';
  static final kRectangleBar3 = 'assets/images/rectangle3.svg';

  ///Customer Table ID Screen
  static final kCustomerRoundImage = 'assets/images/customer.svg';
  static final kSeconds = 4;

  ///Email Sent Screen
  static final kEmailSenTGif = "assets/images/email2.gif";

  ///Welcome Screen
  static final kPizzaWelcomeSvg = "assets/images/pizza.svg";
  static final kJustWelcomeSvg = "assets/images/welcome.svg";
  static final kWelcomeComma1Svg = "assets/images/comma1.svg";
  static final kWelcomeComma2Svg = "assets/images/comma2.svg";

  ///Information Screen
  static final kInformationVoteSvg = "assets/svg/positive_vote.svg";
}
