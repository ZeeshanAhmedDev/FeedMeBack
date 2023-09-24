import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider.dart';
import 'api_constant.dart';

class ApiClient {
  static runLoader(bool boolean, BuildContext context) {
    final loading = Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(boolean);
    return loading;
  }

  static restrictRunLoader(bool boolean, BuildContext context) {
    final loading = Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(boolean);
    return loading;
  }

  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    Map<String, String> _data = {
      'email': email,
      'password': password,
    };
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.post(
        Api.loginPath,
        data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> SignUp(
      String name,
      String OrganizationName,
      String PhoneNumber,
      int industryID,
      int userID,
      int deviceKey,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, dynamic> _data = {
      'name': name,
      'brand_name': OrganizationName,
      'phone_no': PhoneNumber,
      'industry': industryID,
      'user_id': userID,
      'device_key': deviceKey,
    };

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.post(
        Api.verificationDetailsForSignUpPath,
        data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> emailVerification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var code = prefs.getString('CODE');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Response response = await _dio.get(
        Api.signUpPath + "?code=$code",
        // data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object

      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());

      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> logOut(BuildContext context) async {
    runLoader(true, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Response response = await _dio.post(
        Api.logOutPath,
        // data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);

      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(
      String email, BuildContext context) async {
    runLoader(true, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _data = {
      'email': email,
    };
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Response response = await _dio.post(
        Api.forgotPassword,
        data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getFeedBackTakerIds(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.feedbackTakerPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getIndustriesIds(
      BuildContext context) async {
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      Response response = await _dio.get(
        Api.industriesIdPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getFeedBackSpaces(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.feedbackSpacePath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sendFeedbackTakerIds(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.feedbackTakerPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> registerUserOnlyWithEmailScreen(
      String email, BuildContext context) async {
    Map<String, String> _data = {
      'email': email,
    };
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.post(
        Api.registerPath,
        data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sendInformationFeedback(
      String name,
      String phoneNumber,
      String email,
      var brandId,
      var feedbackTakerId,
      var feedbackSpaceId,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, dynamic> _data = {
      "system_id": 1,
      "feedback_taker_id": feedbackTakerId,
      "feedback_space_id": feedbackSpaceId,
      "name": name,
      "phone_number": phoneNumber,
      "email": email,
      "answers": [
        {
          "question_id": 1,
          "question": "question1",
          "question_type": "emoji",
          "total_options": 5,
          "answer": 10
        },
        {
          "question_id": 2,
          "question": "question2",
          "question_type": "emoji",
          "total_options": 5,
          "answer": 10
        }
      ],
      "brand_id": brandId

      // 'name': name,
      // 'phone_number': phoneNumber,
      // 'email': email,
      // 'brand_id': brandId,
      // 'feedback_taker_id': feedbackTakerId,
      // 'feedback_space_id': feedbackSpaceId,
    };

    /*  {
      "system_id":1,
    "feedback_taker_id":1,
    "feedback_space_id":1,
    "name":"trg",
    "phone_number":123,
    "email":"rtet",
    "answers":[{
    "question_id":1,
    "question":"question1",
    "question_type":"emoji",
    "total_options":5,
    "answer":10},{
    "question_id":2,
    "question":"question2",
    "question_type":"emoji",
    "total_options":5,
    "answer":10}
    ],
    "brand_id":4
    }*/

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.post(
        Api.InformationFeedbackPath,
        data: json.encode(_data),
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getAllQuestionsOfSystem(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getInt('getSystemInTheApp_ID');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.getAllQuestionsOfSystemPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getSystemInTheApp(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.getSystemInTheAppPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getBrand(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      runLoader(true, context);

      Response response = await _dio.get(
        Api.getBrandPath,
        options: Options(headers: _headers),
      );

      //returns the successful user data json object
      restrictRunLoader(false, context);
      return response.data;
    } on DioError catch (e) {
      print("This is Exception==> " + e.toString());
      restrictRunLoader(false, context);
      //returns the error object if any
      return e.response!.data;
    }
  }
}
