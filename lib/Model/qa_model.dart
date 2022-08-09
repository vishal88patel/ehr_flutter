class QAModel {
  String? category;
  List<SubCategory>? subCategory;
  String? categoryId;

  QAModel({this.category,this.categoryId, this.subCategory});

  QAModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryId = json['categoryId'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? name;
  bool? isSelected;
  String? modelId;


  SubCategory({this.name, this.isSelected,this.modelId});

  SubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isSelected = json['isSelected'];
    modelId = json['modelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isSelected'] = this.isSelected;
    data['modelId'] = this.modelId;
    return data;
  }
}
