import 'package:flutter/material.dart';


//Routes Names

const String SplashScreen = 'SplashScreen';
const String LoginPage = 'Login';
// const String HomePage = 'HomePage';

//Control our pages Routes Flow

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    // case SplashScreen:
    //   return MaterialPageRoute(builder: (context) => AsleefyIntroScreen());
    // case LoginPage:
    //   return MaterialPageRoute(builder: (context) => LoginScreen());

    default:
      throw ('This Route name does not exist');
  }
}
