class ImageTypeModel {
  int? imageTypeId;
  String? imageType;
  int? sequence;

  ImageTypeModel({this.imageTypeId, this.imageType, this.sequence});

  ImageTypeModel.fromJson(Map<String, dynamic> json) {
    imageTypeId = json['imageTypeId'];
    imageType = json['imageType'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageTypeId'] = this.imageTypeId;
    data['imageType'] = this.imageType;
    data['sequence'] = this.sequence;
    return data;
  }
}
