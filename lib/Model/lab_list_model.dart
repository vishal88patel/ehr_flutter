class LabListModel {
  String? testResultName;
  List<Values>? values;

  LabListModel({this.testResultName, this.values});

  LabListModel.fromJson(Map<String, dynamic> json) {
    testResultName = json['testResultName'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testResultName'] = this.testResultName;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Values {
  int? usersTestResultId;
  int? testResultId;
  String? testResultType;
  String? testResultValue;
  int? created;

  Values(
      {this.usersTestResultId,
        this.testResultId,
        this.testResultType,
        this.testResultValue,
        this.created});

  Values.fromJson(Map<String, dynamic> json) {
    usersTestResultId = json['usersTestResultId'];
    testResultId = json['testResultId'];
    testResultType = json['testResultType'];
    testResultValue = json['testResultValue'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersTestResultId'] = this.usersTestResultId;
    data['testResultId'] = this.testResultId;
    data['testResultType'] = this.testResultType;
    data['testResultValue'] = this.testResultValue;
    data['created'] = this.created;
    return data;
  }
}