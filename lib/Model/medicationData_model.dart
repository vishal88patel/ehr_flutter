class MedicationData {
  List<Frequency>? frequency;
  List<Dosage>? dosage;
  List<FoodType>? foodType;

  MedicationData({this.frequency, this.dosage, this.foodType});

  MedicationData.fromJson(Map<String, dynamic> json) {
    if (json['frequency'] != null) {
      frequency = <Frequency>[];
      json['frequency'].forEach((v) {
        frequency?.add( Frequency.fromJson(v));
      });
    }
    if (json['dosage'] != null) {
      dosage = <Dosage>[];
      json['dosage'].forEach((v) {
        dosage?.add( Dosage.fromJson(v));
      });
    }
    if (json['foodType'] != null) {
      foodType = <FoodType>[];
      json['foodType'].forEach((v) {
        foodType?.add(FoodType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.frequency != null) {
      data['frequency'] = this.frequency?.map((v) => v.toJson()).toList();
    }
    if (this.dosage != null) {
      data['dosage'] = this.dosage?.map((v) => v.toJson()).toList();
    }
    if (this.foodType != null) {
      data['foodType'] = this.foodType?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Frequency {
  int? frequencyTypeId;
  String? frequencyType;
  String? sequence;

  Frequency({this.frequencyTypeId, this.frequencyType, this.sequence});

  Frequency.fromJson(Map<String, dynamic> json) {
    frequencyTypeId = json['frequencyTypeId'];
    frequencyType = json['frequencyType'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frequencyTypeId'] = this.frequencyTypeId;
    data['frequencyType'] = this.frequencyType;
    data['sequence'] = this.sequence;
    return data;
  }
}

class Dosage {
  int? dosageTypeId;
  String? dosageType;
  int? sequence;

  Dosage({this.dosageTypeId, this.dosageType, this.sequence});

  Dosage.fromJson(Map<String, dynamic> json) {
    dosageTypeId = json['dosageTypeId'];
    dosageType = json['dosageType'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dosageTypeId'] = this.dosageTypeId;
    data['dosageType'] = this.dosageType;
    data['sequence'] = this.sequence;
    return data;
  }
}

class FoodType {
  int? medicationFoodTypeId;
  String? medicationFood;
  int? sequence;

  FoodType({this.medicationFoodTypeId, this.medicationFood, this.sequence});

  FoodType.fromJson(Map<String, dynamic> json) {
    medicationFoodTypeId = json['medicationFoodTypeId'];
    medicationFood = json['medicationFood'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicationFoodTypeId'] = this.medicationFoodTypeId;
    data['medicationFood'] = this.medicationFood;
    data['sequence'] = this.sequence;
    return data;
  }
}
