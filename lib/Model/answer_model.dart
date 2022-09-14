class AnswerModel {
  int? questionId;
  String? answers;
  String? description;
  bool? current;
  int? startDate;
  int? endDate;

  AnswerModel({this.questionId, this.answers});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answers = json['answers'];
    description = json['description'];
    current = json['current'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['answers'] = this.answers;
    data['description'] = this.description;
    data['current'] = this.current;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
