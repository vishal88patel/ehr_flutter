class LabListModel {
  int? usersTestResultId;
  int? testResultId;
  String? testResultType;
  String? testResultValue;
  int? testDate;
  int? created;

  LabListModel(
      {this.usersTestResultId,
        this.testResultId,
        this.testResultType,
        this.testResultValue,
        this.testDate,
        this.created});

  LabListModel.fromJson(Map<String, dynamic> json) {
    usersTestResultId = json['usersTestResultId'];
    testResultId = json['testResultId'];
    testResultType = json['testResultType'];
    testResultValue = json['testResultValue'];
    testDate = json['testDate'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersTestResultId'] = this.usersTestResultId;
    data['testResultId'] = this.testResultId;
    data['testResultType'] = this.testResultType;
    data['testResultValue'] = this.testResultValue;
    data['testDate'] = this.testDate;
    data['created'] = this.created;
    return data;
  }
}