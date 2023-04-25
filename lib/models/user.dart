import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfile {
  UserProfile({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    // this.tutorInfo,
    this.walletInfo,
    // this.feedbacks,
    this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    // this.timezone,
    // this.referralInfo,
    // this.avgRating,
    // this.priceOfEachSession,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
  });

  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  dynamic language;
  String? birthday;
  bool? isActivated;
  // dynamic tutorInfo;
  WalletInfo? walletInfo;
  // List<dynamic>? feedbacks;
  List<dynamic>? courses;
  dynamic requireNote;
  dynamic level;
  List<LearnTopic>? learnTopics;
  List<LearnTopic>? testPreparations;
  bool? isPhoneActivated;
  // int? timezone;
  // ReferralInfo? referralInfo;
  // int? avgRating;
  // PriceOfEachSession? priceOfEachSession;
  int? timezone;
  String? studySchedule;
  bool? canSendMessage;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WalletInfo {
  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  factory WalletInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LearnTopic {
  LearnTopic({
    required this.id,
    required this.key,
    required this.name,
  });

  int id;
  String key;
  String name;

  factory LearnTopic.fromJson(Map<String, dynamic> json) =>
      _$LearnTopicFromJson(json);

  Map<String, dynamic> toJson() => _$LearnTopicToJson(this);
}
