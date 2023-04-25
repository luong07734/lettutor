import 'package:json_annotation/json_annotation.dart';
part 'schedule.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleList {
  ScheduleList({
    this.count,
    this.rows,
  });

  int? count;
  List<ScheduleRowItem>? rows;

  factory ScheduleList.fromJson(Map<String, dynamic> json) =>
      _$ScheduleListFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleRowItem {
  ScheduleRowItem({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.showRecordUrl,
    this.studentMaterials,
  });

  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  dynamic studentRequest;
  dynamic tutorReview;
  dynamic scoreByTutor;
  String? createdAt;
  String? updatedAt;
  dynamic recordUrl;
  bool? isDeleted;
  ScheduleDetailInfo? scheduleDetailInfo;
  bool? showRecordUrl;
  List<dynamic>? studentMaterials;

  factory ScheduleRowItem.fromJson(Map<String, dynamic> json) =>
      _$ScheduleRowItemFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleRowItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleDetailInfo {
  ScheduleDetailInfo({
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.scheduleInfo,
  });

  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  ScheduleInfo? scheduleInfo;
  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleInfo {
  ScheduleInfo({
    this.date,
    this.startTimestamp,
    this.endTimestamp,
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.tutorInfo,
  });

  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  TutorInfo? tutorInfo;
  factory ScheduleInfo.fromJson(Map<String, dynamic> json) =>
      _$ScheduleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TutorInfo {
  TutorInfo({
    this.id,
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? level;
  String? email;
  String? google;
  dynamic facebook;
  dynamic apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  dynamic language;
  DateTime? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  dynamic requireNote;
  int? timezone;
  dynamic phoneAuth;
  bool? isPhoneAuthActivated;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory TutorInfo.fromJson(Map<String, dynamic> json) =>
      _$TutorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TutorInfoToJson(this);
}
