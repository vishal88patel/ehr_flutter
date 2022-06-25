class TestResultData {
  int? testTypeId;
  String? testType;
  int? sequence;

  TestResultData({this.testTypeId, this.testType, this.sequence});

  TestResultData.fromJson(Map<String, dynamic> json) {
    testTypeId = json['testTypeId'];
    testType = json['testType'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testTypeId'] = this.testTypeId;
    data['testType'] = this.testType;
    data['sequence'] = this.sequence;
    return data;
  }
}