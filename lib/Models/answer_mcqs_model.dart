class AnswerMcqModel {
  String? companyAnswerId;
  String? companyQuestionnaireId;
  String? companyId;
  String? question;
  String? answerId;
  String? answer;
  String? templateName;

  AnswerMcqModel(
      {this.companyAnswerId,
      this.companyQuestionnaireId,
      this.companyId,
      this.question,
      this.answerId,
      this.answer,
      this.templateName});

  AnswerMcqModel.fromJson(Map<String, dynamic> json) {
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
