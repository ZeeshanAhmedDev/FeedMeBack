import '../utils/helper.dart';

class Api {
  // static const String baseUrl = "http://fmb.digitaezonline.com/api/";
  static const String baseUrl = "http://fmbbackend.digitaezonline.com/api/";
  static const loginPath = baseUrl + "login";
  static const registerPath = baseUrl + "register";
  static const signUpPath = baseUrl + "signup";
  static const verificationDetailsForSignUpPath = baseUrl + "verification";
  static const logOutPath = baseUrl + "logout";
  static const feedbackTakerPath = baseUrl + "feedback-taker";
  static const feedbackSpacePath = baseUrl + "feedback-space";
  static const industriesIdPath = baseUrl + "industry";
  static const InformationFeedbackPath = baseUrl + "feedback";

  static String getAllQuestionsOfSystemPath =
      baseUrl + "system/${Helper.getAllQuestionsOfSystemPath_ID}/edit";

  static const getBrandPath = baseUrl + "brand";

  static String getSystemInTheAppPath =
      baseUrl + "system-in-app/${Helper.getBrandID}";
  static const forgotPassword = baseUrl + "forgot-password";

  /// ------------------------------------------------------------
  ///
  ///
  static const showIndustry = baseUrl + "showIndustry";

  static const createFeedbackIDs = baseUrl + "createFeedBackId";
  static const createCustomer = baseUrl + "createCustomer";
  static const createCustomerReply = baseUrl + "createCustomerReply";
  static const createFeedBackTakerId = baseUrl + "createFeedBackTakerId";

  static createApi(String id) {
    baseUrl + "/getCompanyQuestionnaire/$id";
  }
}
