class MedicationModel {
  int? usersMedicationId;
  String? medicationName;
  String? dosage;
  int? dosageId;
  String? dosageType;
  int? foodId;
  String? medicationFood;
  int? startDate;
  int? endDate;
  int? frequencyId;
  String? frequencyType;
  int? created;

  MedicationModel(
      {this.usersMedicationId,
        this.medicationName,
        this.dosage,
        this.dosageId,
        this.dosageType,
        this.foodId,
        this.medicationFood,
        this.startDate,
        this.endDate,
        this.frequencyId,
        this.frequencyType,
        this.created});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    usersMedicationId = json['usersMedicationId'];
    medicationName = json['medicationName'];
    dosage = json['dosage'];
    dosageId = json['dosageId'];
    dosageType = json['dosageType'];
    foodId = json['foodId'];
    medicationFood = json['medicationFood'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    frequencyId = json['frequencyId'];
    frequencyType = json['frequencyType'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersMedicationId'] = this.usersMedicationId;
    data['medicationName'] = this.medicationName;
    data['dosage'] = this.dosage;
    data['dosageId'] = this.dosageId;
    data['dosageType'] = this.dosageType;
    data['foodId'] = this.foodId;
    data['medicationFood'] = this.medicationFood;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['frequencyId'] = this.frequencyId;
    data['frequencyType'] = this.frequencyType;
    data['created'] = this.created;
    return data;
  }
}