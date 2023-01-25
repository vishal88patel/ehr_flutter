class SupplementModel {
  int? supplementId;
  String? supplementName;
  String? dosage;
  int? withFoodId;
  int? startDate;
  int? endDate;
  bool? isOngoing;
  int? frequencyType;
  int? created;

  SupplementModel(
      {this.supplementId,
        this.supplementName,
        this.dosage,
        this.withFoodId,
        this.startDate,
        this.endDate,
        this.isOngoing,
        this.frequencyType,
        this.created});

  SupplementModel.fromJson(Map<String, dynamic> json) {
    supplementId = json['supplementId'];
    supplementName = json['supplementName'];
    dosage = json['dosage'];
    withFoodId = json['withFoodId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isOngoing = json['isOngoing'];
    frequencyType = json['frequencyType'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplementId'] = this.supplementId;
    data['supplementName'] = this.supplementName;
    data['dosage'] = this.dosage;
    data['withFoodId'] = this.withFoodId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['isOngoing'] = this.isOngoing;
    data['frequencyType'] = this.frequencyType;
    data['created'] = this.created;
    return data;
  }
}