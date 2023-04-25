// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleOfTutor _$ScheduleOfTutorFromJson(Map<String, dynamic> json) =>
    ScheduleOfTutor(
      id: json['id'] as String?,
      tutorId: json['tutorId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isBooked: json['isBooked'] as bool?,
      scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
          ?.map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleOfTutorToJson(ScheduleOfTutor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isBooked': instance.isBooked,
      'scheduleDetails':
          instance.scheduleDetails?.map((e) => e.toJson()).toList(),
    };

ScheduleDetail _$ScheduleDetailFromJson(Map<String, dynamic> json) =>
    ScheduleDetail(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      id: json['id'] as String?,
      scheduleId: json['scheduleId'] as String?,
      startPeriod: json['startPeriod'] as String?,
      endPeriod: json['endPeriod'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      bookingInfo: (json['bookingInfo'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isBooked: json['isBooked'] as bool?,
    );

Map<String, dynamic> _$ScheduleDetailToJson(ScheduleDetail instance) =>
    <String, dynamic>{
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'bookingInfo': instance.bookingInfo?.map((e) => e.toJson()).toList(),
      'isBooked': instance.isBooked,
    };

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
      createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
      updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      scheduleDetailId: json['scheduleDetailId'] as String?,
      tutorMeetingLink: json['tutorMeetingLink'] as String?,
      studentMeetingLink: json['studentMeetingLink'] as String?,
      studentRequest: json['studentRequest'] as String?,
      tutorReview: json['tutorReview'] as String?,
      scoreByTutor: json['scoreByTutor'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      recordUrl: json['recordUrl'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'id': instance.id,
      'userId': instance.userId,
      'scheduleDetailId': instance.scheduleDetailId,
      'tutorMeetingLink': instance.tutorMeetingLink,
      'studentMeetingLink': instance.studentMeetingLink,
      'studentRequest': instance.studentRequest,
      'tutorReview': instance.tutorReview,
      'scoreByTutor': instance.scoreByTutor,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'recordUrl': instance.recordUrl,
      'isDeleted': instance.isDeleted,
    };
