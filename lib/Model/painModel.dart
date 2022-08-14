class PainModel {
  int? usersPainId;
  int? bodyPartId;
  String? bodyPart;
  dynamic locationX;
  dynamic locationY;
  String? description;
  int? startDate;
  int? endDate;
  int? created;

  PainModel(
      {this.usersPainId,
        this.bodyPartId,
        this.bodyPart,
        this.locationX,
        this.locationY,
        this.description,
        this.startDate,
        this.endDate,
        this.created});

  PainModel.fromJson(Map<String, dynamic> json) {
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