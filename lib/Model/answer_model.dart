class AnswerModel {
  int? questionId;
  String? answers;

  AnswerModel({this.questionId, this.answers});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answers = json['answers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['answers'] = this.answers;
    return data;
  }
}
