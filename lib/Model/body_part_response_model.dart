class BodyPartListResponseModel {
  int? bodyPartId;
  String? bodyPart;

  BodyPartListResponseModel({this.bodyPartId, this.bodyPart});

  BodyPartListResponseModel.fromJson(Map<String, dynamic> json) {
    bodyPartId = json['bodyPartId'];
    bodyPart = json['bodyPart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bodyPartId'] = this.bodyPartId;
    data['bodyPart'] = this.bodyPart;
    return data;
  }
}
