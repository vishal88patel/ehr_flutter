class TestResultData {
  int? testTypeId;
  String? testType;
  int? sequence;
  bool? askForName;
  dynamic? shortCodeTypeId;
  dynamic? shortCodeType;

  TestResultData(
      {this.testTypeId,
        this.testType,
        this.sequence,
        this.askForName,
        this.shortCodeTypeId,
        this.shortCodeType});

  TestResultData.fromJson(Map<String, dynamic> json) {
    testTypeId = json['testTypeId'];
    testType = json['testType'];
    sequence = json['sequence'];
    askForName = json['askForName'];
    shortCodeTypeId = json['shortCodeTypeId'];
    shortCodeType = json['shortCodeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testTypeId'] = this.testTypeId;
    data['testType'] = this.testType;
    data['sequence'] = this.sequence;
    data['askForName'] = this.askForName;
    data['shortCodeTypeId'] = this.shortCodeTypeId;
    data['shortCodeType'] = this.shortCodeType;
    return data;
  }
}
