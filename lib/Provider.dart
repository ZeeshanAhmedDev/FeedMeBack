import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'Models/user_model.dart';
import 'UpdatedNewModel/questions_model.dart';

class DataProviders extends ChangeNotifier {
  String? getName = '';
  String? quoteVariable;
  String? dropdownValue;
  String? dropdownValueForFeedSpace;
  double currentSliderValue = 1;
  double customSizedBox = 60;
  bool showSpinner = false;

  QuestionsModel _questionsModel = new QuestionsModel();
  UserModel _user = new UserModel();

  void updateUserObject(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void updateQuestionObject(QuestionsModel questionsModel) {
    _questionsModel = questionsModel;
    notifyListeners();
  }

  getname(String value) {
    getName = value;
    notifyListeners();
  }

  getQuote(String value) {
    quoteVariable = value;
    notifyListeners();
  }

  changeDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  changeDropdownValueForFeedSpace(String value) {
    dropdownValueForFeedSpace = value;
    notifyListeners();
  }

  changeSliderValue(double value) {
    currentSliderValue = value;
    notifyListeners();
  }

  isTrueOrFalseFunctionProgressHUD(bool value) {
    showSpinner = value;
    notifyListeners();
  }

  changeValueOfSizedBox({required double value}) {
    Future.delayed(Duration.zero, () async {
      customSizedBox = value;
    });
    notifyListeners();
    log("customSizedBox == " + customSizedBox.toString());
  }
}
