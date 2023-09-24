class RatingImagesModel {
  String? id;
  String? companyId;
  String? questionnaireId;
  String? companyQuestionnaireId;
  String? image;
  String? vectorType;
  String? createdAt;
  String? updatedAt;

  RatingImagesModel(
      {this.id,
      this.companyId,
      this.questionnaireId,
      this.companyQuestionnaireId,
      this.image,
      this.vectorType,
      this.createdAt,
      this.updatedAt});

  RatingImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    questionnaireId = json['questionnaire_id'];
    companyQuestionnaireId = json['company_questionnaire_id'];
    image = json['image'];
    vectorType = json['vector_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['questionnaire_id'] = this.questionnaireId;
    data['company_questionnaire_id'] = this.companyQuestionnaireId;
    data['image'] = this.image;
    data['vector_type'] = this.vectorType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
