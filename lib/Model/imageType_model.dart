class ImageTypeModel {
  int? imageTypeId;
  String? imageType;
  int? sequence;
  bool? askForName;

  ImageTypeModel(
      {this.imageTypeId, this.imageType, this.sequence, this.askForName});

  ImageTypeModel.fromJson(Map<String, dynamic> json) {
    imageTypeId = json['imageTypeId'];
    imageType = json['imageType'];
    sequence = json['sequence'];
    askForName = json['askForName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageTypeId'] = this.imageTypeId;
    data['imageType'] = this.imageType;
    data['sequence'] = this.sequence;
    data['askForName'] = this.askForName;
    return data;
  }
}
