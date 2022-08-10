class QAModel {
  int? questionId;
  String? questionText;
  int? shortCodeTypeId;
  String? shortCodeType;
  List<Options>? options;

  QAModel(
      {this.questionId,
        this.questionText,
        this.shortCodeTypeId,
        this.shortCodeType,
        this.options});

  QAModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionText = json['questionText'];
    shortCodeTypeId = json['shortCodeTypeId'];
    shortCodeType = json['shortCodeType'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionText'] = this.questionText;
    data['shortCodeTypeId'] = this.shortCodeTypeId;
    data['shortCodeType'] = this.shortCodeType;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? optionId;
  int? questionId;
  String? optionText;
  String? optionValue;
  bool? isSelected;

  Options({this.optionId, this.questionId, this.optionText, this.optionValue,this.isSelected});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    questionId = json['questionId'];
    optionText = json['optionText'];
    optionValue = json['optionValue'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    data['questionId'] = this.questionId;
    data['optionText'] = this.optionText;
    data['optionValue'] = this.optionValue;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
