class getCompanyPolarQuestionnaireModel {
  String? id;
  String? companyId;
  String? questionnaireId;
  String? companyQuestionnaireId;
  String? name;
  String? thresholdId;
  String? createdAt;
  String? updatedAt;

  getCompanyPolarQuestionnaireModel(
      {this.id,
      this.companyId,
      this.questionnaireId,
      this.companyQuestionnaireId,
      this.name,
      this.thresholdId,
      this.createdAt,
      this.updatedAt});

  getCompanyPolarQuestionnaireModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    questionnaireId = json['questionnaire_id'];
    companyQuestionnaireId = json['company_questionnaire_id'];
    name = json['name'];
    thresholdId = json['threshold_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['questionnaire_id'] = this.questionnaireId;
    data['company_questionnaire_id'] = this.companyQuestionnaireId;
    data['name'] = this.name;
    data['threshold_id'] = this.thresholdId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
