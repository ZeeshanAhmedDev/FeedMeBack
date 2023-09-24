import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) =>
    json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.email,
  });

  var email;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
