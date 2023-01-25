class LabScreenResponseModel {
  List<Pains>? pains;
  List<Medications>? medications;
  List<TestResults>? testResults;
  List<Imagine>? imagine;
  List<Supplements>? supplements;
  List<HeighWeightResponse>? heighWeightResponse;

  LabScreenResponseModel(
      {this.pains, this.medications, this.testResults, this.imagine,this.supplements,this.heighWeightResponse});

  LabScreenResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['pains'] != null) {
      pains = <Pains>[];
      json['pains'].forEach((v) {
        pains!.add(new Pains.fromJson(v));
      });
    }
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(new Medications.fromJson(v));
      });
    }
    if (json['testResults'] != null) {
      testResults = <TestResults>[];
      json['testResults'].forEach((v) {
        testResults!.add(new TestResults.fromJson(v));
      });
    }
    if (json['supplements'] != null) {
      supplements = <Supplements>[];
      json['supplements'].forEach((v) {
        supplements!.add(new Supplements.fromJson(v));
      });
    }
    if (json['imagine'] != null) {
      imagine = <Imagine>[];
      json['imagine'].forEach((v) {
        imagine!.add(new Imagine.fromJson(v));
      });
    }
    if (json['heighWeightResponse'] != null) {
      heighWeightResponse = <HeighWeightResponse>[];
      json['heighWeightResponse'].forEach((v) {
        heighWeightResponse!.add(new HeighWeightResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pains != null) {
      data['pains'] = this.pains!.map((v) => v.toJson()).toList();
    }
    if (this.medications != null) {
      data['medications'] = this.medications!.map((v) => v.toJson()).toList();
    }
    if (this.testResults != null) {
      data['testResults'] = this.testResults!.map((v) => v.toJson()).toList();
    }
    if (this.supplements != null) {
      data['supplements'] = this.supplements!.map((v) => v.toJson()).toList();
    }
    if (this.imagine != null) {
      data['imagine'] = this.imagine!.map((v) => v.toJson()).toList();
    }
    if (this.heighWeightResponse != null) {
      data['heighWeightResponse'] =
          this.heighWeightResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pains {
  int? usersPainId;
  int? bodyPartId;
  String? bodyPart;
  dynamic? locationX;
  dynamic? locationY;
  String? description;
  int? startDate;
  int? endDate;
  int? created;

  Pains(
      {this.usersPainId,
        this.bodyPartId,
        this.bodyPart,
        this.locationX,
        this.locationY,
        this.description,
        this.startDate,
        this.endDate,
        this.created});

  Pains.fromJson(Map<String, dynamic> json) {
    usersPainId = json['usersPainId'];
    bodyPartId = json['bodyPartId'];
    bodyPart = json['bodyPart'];
    locationX = json['locationX'];
    locationY = json['locationY'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersPainId'] = this.usersPainId;
    data['bodyPartId'] = this.bodyPartId;
    data['bodyPart'] = this.bodyPart;
    data['locationX'] = this.locationX;
    data['locationY'] = this.locationY;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['created'] = this.created;
    return data;
  }
}

class Medications {
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

  Medications(
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

  Medications.fromJson(Map<String, dynamic> json) {
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

class Supplements {
  int? supplementId;
  String? supplementName;
  String? dosage;
  int? withFoodId;
  int? startDate;
  int? endDate;
  bool? isOngoing;
  Null? frequencyType;
  int? created;

  Supplements(
      {this.supplementId,
        this.supplementName,
        this.dosage,
        this.withFoodId,
        this.startDate,
        this.endDate,
        this.isOngoing,
        this.frequencyType,
        this.created});

  Supplements.fromJson(Map<String, dynamic> json) {
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

class TestResults {
  String? testResultName;
  List<Values>? values;

  TestResults({this.testResultName, this.values});

  TestResults.fromJson(Map<String, dynamic> json) {
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
  int? testDate;
  int? created;

  Values(
      {this.usersTestResultId,
        this.testResultId,
        this.testResultType,
        this.testResultValue,
        this.testDate,
        this.created});

  Values.fromJson(Map<String, dynamic> json) {
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

class Imagine {
  int? usersImagineId;
  int? imagineTypeId;
  String? imageType;
  String? description;
  int? created;
  List<Media>? media;

  Imagine(
      {this.usersImagineId,
        this.imagineTypeId,
        this.imageType,
        this.description,
        this.created,
        this.media});

  Imagine.fromJson(Map<String, dynamic> json) {
    usersImagineId = json['usersImagineId'];
    imagineTypeId = json['imagineTypeId'];
    imageType = json['imageType'];
    description = json['description'];
    created = json['created'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersImagineId'] = this.usersImagineId;
    data['imagineTypeId'] = this.imagineTypeId;
    data['imageType'] = this.imageType;
    data['description'] = this.description;
    data['created'] = this.created;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? usersImagineId;
  String? mediaFileName;
  String? mediaType;
  double? mediaSize;

  Media(
      {this.usersImagineId,
        this.mediaFileName,
        this.mediaType,
        this.mediaSize});

  Media.fromJson(Map<String, dynamic> json) {
    usersImagineId = json['usersImagineId'];
    mediaFileName = json['mediaFileName'];
    mediaType = json['mediaType'];
    mediaSize = json['mediaSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersImagineId'] = this.usersImagineId;
    data['mediaFileName'] = this.mediaFileName;
    data['mediaType'] = this.mediaType;
    data['mediaSize'] = this.mediaSize;
    return data;
  }
}

class HeighWeightResponse {
  int? height;
  int? weight;
  int? changedDate;

  HeighWeightResponse({this.height, this.weight, this.changedDate});

  HeighWeightResponse.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    changedDate = json['changedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['changedDate'] = this.changedDate;
    return data;
  }
}