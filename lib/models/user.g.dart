// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      language: json['language'],
      birthday: json['birthday'] as String?,
      isActivated: json['isActivated'] as bool?,
      walletInfo: json['walletInfo'] == null
          ? null
          : WalletInfo.fromJson(json['walletInfo'] as Map<String, dynamic>),
      courses: json['courses'] as List<dynamic>?,
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: (json['learnTopics'] as List<dynamic>?)
          ?.map((e) => LearnTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      testPreparations: (json['testPreparations'] as List<dynamic>?)
          ?.map((e) => LearnTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPhoneActivated: json['isPhoneActivated'] as bool?,
      timezone: json['timezone'] as int?,
      studySchedule: json['studySchedule'] as String?,
      canSendMessage: json['canSendMessage'] as bool?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'country': instance.country,
      'phone': instance.phone,
      'roles': instance.roles,
      'language': instance.language,
      'birthday': instance.birthday,
      'isActivated': instance.isActivated,
      'walletInfo': instance.walletInfo?.toJson(),
      'courses': instance.courses,
      'requireNote': instance.requireNote,
      'level': instance.level,
      'learnTopics': instance.learnTopics?.map((e) => e.toJson()).toList(),
      'testPreparations':
          instance.testPreparations?.map((e) => e.toJson()).toList(),
      'isPhoneActivated': instance.isPhoneActivated,
      'timezone': instance.timezone,
      'studySchedule': instance.studySchedule,
      'canSendMessage': instance.canSendMessage,
    };

WalletInfo _$WalletInfoFromJson(Map<String, dynamic> json) => WalletInfo(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      amount: json['amount'] as String?,
      isBlocked: json['isBlocked'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      bonus: json['bonus'] as int?,
    );

Map<String, dynamic> _$WalletInfoToJson(WalletInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'isBlocked': instance.isBlocked,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bonus': instance.bonus,
    };

LearnTopic _$LearnTopicFromJson(Map<String, dynamic> json) => LearnTopic(
      id: json['id'] as int,
      key: json['key'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LearnTopicToJson(LearnTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
    };
