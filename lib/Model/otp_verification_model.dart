class OtpVerificationModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePicture;
  int? birthdate;
  String? email;
  int? height;
  int? weight;
  bool? emailConfirmed;
  String? countryCode;
  String? phoneNumber;
  bool? phoneConfirmed;
  String? userRole;
  int? genderId;
  String? refreshToken;
  bool? registrationCompleted;

  OtpVerificationModel(
      {this.userId,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePicture,
        this.birthdate,
        this.email,
        this.height,
        this.weight,
        this.genderId,
        this.emailConfirmed,
        this.countryCode,
        this.phoneNumber,
        this.phoneConfirmed,
        this.userRole,
        this.refreshToken,
        this.registrationCompleted});

  OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePicture = json['profilePicture'];
    birthdate = json['birthdate'];
    email = json['email'];
    height = json['height'];
    weight = json['weight'];
    emailConfirmed = json['emailConfirmed'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    phoneConfirmed = json['phoneConfirmed'];
    userRole = json['userRole'];
    genderId = json['genderId']??0;
    refreshToken = json['refreshToken'];
    registrationCompleted = json['registrationCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['emailConfirmed'] = this.emailConfirmed;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneConfirmed'] = this.phoneConfirmed;
    data['userRole'] = this.userRole;
    data['refreshToken'] = this.refreshToken;
    data['registrationCompleted'] = this.registrationCompleted;
    return data;
  }
}
