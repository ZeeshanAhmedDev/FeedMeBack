import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/auth_services.dart';
import '../../config/themes/theme.dart';
import '../../modules/auth/screens/signin_screen.dart';

PreferredSizeWidget appBar(
    BuildContext context, Orientation orientation, String text,
    {isWhite = false}) {
  return AppBar(
      centerTitle: true,
      foregroundColor: Colors.black,
      backgroundColor: isWhite ? Colors.white : Colors.transparent,
      title: Text(
        text,
        style: TextStyle(
            color: Color(AppColor.lightgreen),
            fontSize: orientation == Orientation.portrait ? 23.sp : 39.sp),
      ),
      elevation: 0,
      leading: popup(context));
}

Widget popup(BuildContext context) {
  return PopupMenuButton<int>(
      offset: Offset(20, 45),
      color: Color(AppColor.lightgreen),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (context) => [
            PopupMenuItem<int>(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 16),
              value: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/logout.svg',
                    color: Colors.white,
                    width: 15.81.w,
                    height: 15.84.h,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text("Logout", style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ],
      onSelected: (item) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic res = await ApiClient.logOut(context);

        if (res['status']) {
          prefs.clear();
          print("$res");

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SignInScreen()));
        } else {
          print("$res");
        }
      });
}
