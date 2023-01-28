class HeightWeightModel {
  int? height;
  int? weight;
  int? changedDate;

  HeightWeightModel({this.height, this.weight, this.changedDate});

  HeightWeightModel.fromJson(Map<String, dynamic> json) {
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
