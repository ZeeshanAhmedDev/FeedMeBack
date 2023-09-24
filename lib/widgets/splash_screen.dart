import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:feedmeback/views/feedback_taker_ID.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart' as FT;
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/onbroading/Screens/onbroading_screen.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  //====================================================================
  Future checkFirstSeen() async {
    Timer(
      Duration(seconds: Constants.kSeconds),
      () async {
        final sharedPref = await SharedPreferences.getInstance();
        final token = await sharedPref.getString('token');
        if (token != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const TakeFeedbackIDScreen()),
          );

          Helper.isInternetConnected == true
              ? SizedBox()
              : FT.Fluttertoast.showToast(
                  msg: "Your device is not connected to internet. Please Retry",
                  toastLength: FT.Toast.LENGTH_LONG,
                );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          );
          Helper.isInternetConnected == true
              ? SizedBox()
              : FT.Fluttertoast.showToast(
                  msg: "Your device is not connected to internet. Please Retry",
                  toastLength: FT.Toast.LENGTH_LONG,
                );
        }
      },
    );
  }
  //====================================================================

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: OrientationBuilder(builder: (context, orientation) {
          return Center(
            child: Image.asset(
              Constants.kSplashScreenGifFile,
              fit: BoxFit.contain,
              width: orientation == Orientation.portrait ? 378.w : 800.w,
              height: orientation == Orientation.portrait ? 378.h : 800.h,
              // scale: 0.8,
            ),
          );
        }),
      ),
    );
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        Helper.isInternetConnected = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        Helper.isInternetConnected = true;
      });
    }
  }
}
