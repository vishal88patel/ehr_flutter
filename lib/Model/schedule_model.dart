class ScheduleModel {
  int? usersScheduleId;
  String? comment;
  int? scheduleDateTime;

  ScheduleModel({this.usersScheduleId, this.comment, this.scheduleDateTime});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    usersScheduleId = json['usersScheduleId'];
    comment = json['comment'];
    scheduleDateTime = json['scheduleDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersScheduleId'] = this.usersScheduleId;
    data['comment'] = this.comment;
    data['scheduleDateTime'] = this.scheduleDateTime;
    return data;
  }
}