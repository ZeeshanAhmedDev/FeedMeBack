// To parse this JSON data, do
//
//     final getAllQuestionsModel = getAllQuestionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel getAllQuestionsModelFromJson(String str) =>
    QuestionsModel.fromJson(json.decode(str));

String getAllQuestionsModelToJson(QuestionsModel data) =>
    json.encode(data.toJson());

class QuestionsModel {
  QuestionsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<List<Datum>>? data;

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        status: json["status"],
        message: json["message"],
        data: List<List<Datum>>.from(json["data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(
            data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.industryId,
    required this.brandId,
    required this.questions,
  });

  int? id;
  String? name;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? industryId;
  dynamic brandId;
  List<Question> questions;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        industryId: json["industry_id"],
        brandId: json["brand_id"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "industry_id": industryId,
        "brand_id": brandId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.screenTitle,
    this.name,
    this.description,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.feedbackId,
    this.questionTypeId,
    this.type,
  });

  int? id;
  String? screenTitle;
  String? name;
  String? description;
  dynamic value;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? feedbackId;
  String? questionTypeId;
  Type? type;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        screenTitle: json["screen_title"],
        name: json["name"],
        description: json["description"],
        value: json["value"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        feedbackId: json["feedback_id"],
        questionTypeId: json["question_type_id"],
        type: Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "screen_title": screenTitle,
        "name": name,
        "description": description,
        "value": value,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "feedback_id": feedbackId,
        "question_type_id": questionTypeId,
        "type": type?.toJson(),
      };
}

class Type {
  Type({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
