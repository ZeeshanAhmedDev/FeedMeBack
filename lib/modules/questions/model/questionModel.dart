class QuestionModel {
  String question;
  String type;

  QuestionModel(this.question, this.type);
}

List<QuestionModel> questions = [
  QuestionModel("How was our service?", "choice"),
  QuestionModel("How was the Internet?", "reaction"),
  QuestionModel("How was our Environment?", "scale"),
  QuestionModel("Would you recommend us to others?", "boolean"),
  QuestionModel(
      "What do you think about what will make us better?", "descriptive"),
  QuestionModel("How would you rate our overall experience?", "rating"),
];

int index = 0;
