import 'package:json_annotation/json_annotation.dart';
part 'tutor_schedule.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleOfTutor {
  ScheduleOfTutor({
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.scheduleDetails,
  });

  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  DateTime? createdAt;
  bool? isBooked;
  List<ScheduleDetail>? scheduleDetails;

  factory ScheduleOfTutor.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOfTutorFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleOfTutorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleDetail {
  ScheduleDetail({
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.bookingInfo,
    this.isBooked,
  });

  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingInfo {
  BookingInfo({
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
  });

  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? recordUrl;
  bool? isDeleted;

  factory BookingInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}
