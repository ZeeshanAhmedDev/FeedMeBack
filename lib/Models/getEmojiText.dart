class GetEmojiTextModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetEmojiTextModel({this.success, this.message, this.data});

  GetEmojiTextModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? companyAnswerId;
  String? companyQuestionnaireId;
  String? companyId;
  String? question;
  String? answerId;
  String? answer;
  String? templateName;

  Data(
      {this.companyAnswerId,
      this.companyQuestionnaireId,
      this.companyId,
      this.question,
      this.answerId,
      this.answer,
      this.templateName});

  Data.fromJson(Map<String, dynamic> json) {
    companyAnswerId = json['company_answer_id'];
    companyQuestionnaireId = json['company_questionnaire_id'];
    companyId = json['company_id'];
    question = json['question'];
    answerId = json['answer_id'];
    answer = json['answer'];
    templateName = json['template_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_answer_id'] = this.companyAnswerId;
    data['company_questionnaire_id'] = this.companyQuestionnaireId;
    data['company_id'] = this.companyId;
    data['question'] = this.question;
    data['answer_id'] = this.answerId;
    data['answer'] = this.answer;
    data['template_name'] = this.templateName;
    return data;
  }
}
