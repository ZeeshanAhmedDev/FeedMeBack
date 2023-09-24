import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:feedmeback/utils/helper.dart';
import 'package:feedmeback/utils/network_connectivity.dart';
import 'package:feedmeback/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart' as UniLink;
import 'Provider.dart';
import 'Services/auth_services.dart';
import 'modules/auth/screens/register_user_with_only_email.dart';
import 'modules/auth/screens/signup_screen.dart';
import 'widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // StreamSubscription _sub;
  checkDeepLink();
  runApp(MyApp());

  /// lock screen to portrait Mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future checkDeepLink() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    print("checkDeepLink");
    await UniLink.getInitialLink();
    Helper.sub = UniLink.uriLinkStream.listen((Uri? uri) {
      print(uri);

      Helper.uriTaker = uri;

      var get = Helper.uriTaker!.path
          .replaceAll('https://fmb-front.digitaezonline.com/signup/', "");
      get = get.replaceAll('/signup/', '');
      print("------Get String------------> " + get);
      prefs.setString('CODE', get);

      getFeedBackTakerIds();
    }, onError: (err) {
      print("onError");
    });
  } on PlatformException {
    print("PlatformException");
  }
}

Future<void> getFeedBackTakerIds() async {
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
}

/*Future getWebsiteData() async {
  final url = Uri.parse('https://fmb-front.digitaezonline.com/signup/');
  final response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);

  final token = html
      .querySelectorAll('h1:nth-child(3) > a')
      .map((element) => element.innerHtml.trim())
      .toList();

  print("url -------> ${token.length}");
  for (final id in token) {
    debugPrint("url ------->" + id);
  }
}*/

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    Helper.sub?.cancel();
    super.dispose();
  }

  ///----------------------------------------------------------------------

  ///-------------------------------------
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        Helper.string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        Helper.string = 'Wifi: Online';
        break;
      case ConnectivityResult.none:
      default:
        Helper.string = 'Offline';
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        designSize: Size(Constants.widthDimension, Constants.heightDimension),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DataProviders(),
            )
          ],
          builder: (context, child) {
            return GetMaterialApp(
              title: StringResource.app_Name,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Constants.kBlueColor,
              ),
              builder: (context, widget) {
                ScreenUtil.setContext(context);
                return widget!;
              },
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
