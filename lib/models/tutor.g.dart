// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      id: json['id'] as String?,
      level: json['level'] as String?,
      email: json['email'] as String?,
      google: json['google'] as String?,
      facebook: json['facebook'],
      apple: json['apple'],
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      language: json['language'],
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      requestPassword: json['requestPassword'] as bool?,
      isActivated: json['isActivated'] as bool?,
      isPhoneActivated: json['isPhoneActivated'] as bool?,
      requireNote: json['requireNote'],
      timezone: json['timezone'] as int?,
      phoneAuth: json['phoneAuth'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'],
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'email': instance.email,
      'google': instance.google,
      'facebook': instance.facebook,
      'apple': instance.apple,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'language': instance.language,
      'birthday': instance.birthday?.toIso8601String(),
      'requestPassword': instance.requestPassword,
      'isActivated': instance.isActivated,
      'isPhoneActivated': instance.isPhoneActivated,
      'requireNote': instance.requireNote,
      'timezone': instance.timezone,
      'phoneAuth': instance.phoneAuth,
      'isPhoneAuthActivated': instance.isPhoneAuthActivated,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
    };

FavoriteTutor _$FavoriteTutorFromJson(Map<String, dynamic> json) =>
    FavoriteTutor(
      id: json['id'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      secondInfo: json['secondInfo'] == null
          ? null
          : Info.fromJson(json['secondInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteTutorToJson(FavoriteTutor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstId': instance.firstId,
      'secondId': instance.secondId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'secondInfo': instance.secondInfo?.toJson(),
    };

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      id: json['id'] as String?,
      bookingId: json['bookingId'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      rating: json['rating'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      firstInfo: json['firstInfo'] == null
          ? null
          : Info.fromJson(json['firstInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'firstId': instance.firstId,
      'secondId': instance.secondId,
      'rating': instance.rating,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'firstInfo': instance.firstInfo?.toJson(),
    };

TutorRowItem _$TutorRowItemFromJson(Map<String, dynamic> json) => TutorRowItem(
      level: json['level'] as String?,
      email: json['email'] as String?,
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      language: json['language'],
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      requestPassword: json['requestPassword'] as bool?,
      isActivated: json['isActivated'] as bool?,
      isPhoneActivated: json['isPhoneActivated'],
      requireNote: json['requireNote'],
      timezone: json['timezone'] as int?,
      phoneAuth: json['phoneAuth'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'],
      feedbacks: (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => Feedback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorRowItemToJson(TutorRowItem instance) =>
    <String, dynamic>{
      'level': instance.level,
      'email': instance.email,
      'google': instance.google,
      'facebook': instance.facebook,
      'apple': instance.apple,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'language': instance.language,
      'birthday': instance.birthday?.toIso8601String(),
      'requestPassword': instance.requestPassword,
      'isActivated': instance.isActivated,
      'isPhoneActivated': instance.isPhoneActivated,
      'requireNote': instance.requireNote,
      'timezone': instance.timezone,
      'phoneAuth': instance.phoneAuth,
      'isPhoneAuthActivated': instance.isPhoneAuthActivated,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'feedbacks': instance.feedbacks,
    };

Tutors _$TutorsFromJson(Map<String, dynamic> json) => Tutors(
      count: json['count'] as int,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => TutorRowItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorsToJson(Tutors instance) => <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };
