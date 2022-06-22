class CountryModel {
  int? countryCodeId;
  String? countryName;
  String? mobileCode;
  String? shortCode;
  bool? defaultCountry;

  CountryModel(
      {this.countryCodeId,
        this.countryName,
        this.mobileCode,
        this.shortCode,
        this.defaultCountry});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryCodeId = json['countryCodeId'];
    countryName = json['countryName'];
    mobileCode = json['mobileCode'];
    shortCode = json['shortCode'];
    defaultCountry = json['defaultCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCodeId'] = this.countryCodeId;
    data['countryName'] = this.countryName;
    data['mobileCode'] = this.mobileCode;
    data['shortCode'] = this.shortCode;
    data['defaultCountry'] = this.defaultCountry;
    return data;
  }
}
