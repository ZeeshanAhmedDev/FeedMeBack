class AnswerQuoteModel {
  String? id;
  String? quote;
  String? companyId;

  AnswerQuoteModel({
    this.id,
    this.quote,
    this.companyId,
  });

  AnswerQuoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote'] = this.quote;
    data['company_id'] = this.companyId;
    return data;
  }
}
