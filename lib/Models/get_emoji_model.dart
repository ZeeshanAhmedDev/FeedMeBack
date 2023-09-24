class GetEmojiModel {
  String? id;
  String? questionnaireId;
  String? image;
  String? showName;
  String? createdAt;
  String? updatedAt;

  GetEmojiModel(
      {this.id,
      this.questionnaireId,
      this.image,
      this.showName,
      this.createdAt,
      this.updatedAt});

  GetEmojiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionnaireId = json['questionnaire_id'];
    image = json['image'];
    showName = json['show_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionnaire_id'] = this.questionnaireId;
    data['image'] = this.image;
    data['show_name'] = this.showName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
