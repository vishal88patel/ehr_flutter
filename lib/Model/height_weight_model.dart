class HeightWeightModel {
  int? weight;
  int? changedDate;

  HeightWeightModel({ this.weight, this.changedDate});

  HeightWeightModel.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    changedDate = json['changedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['changedDate'] = this.changedDate;
    return data;
  }
}
