class DropDownModelInTableID {
  var id;
  var companyId;
  var inputType;
  var feedbackNo;
  var createdAt;
  var updatedAt;

  DropDownModelInTableID(
      {this.id,
      this.companyId,
      this.inputType,
      this.feedbackNo,
      this.createdAt,
      this.updatedAt});

  DropDownModelInTableID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    inputType = json['input_type'];
    feedbackNo = json['feedback_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['input_type'] = this.inputType;
    data['feedback_no'] = this.feedbackNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
