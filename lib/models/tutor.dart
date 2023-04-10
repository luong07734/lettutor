// import 'package:json_annotation/json_annotation.dart';

import 'package:json_annotation/json_annotation.dart';
part 'tutor.g.dart';

// base
@JsonSerializable(explicitToJson: true)
class Info {
  Info({
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
    // this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.createdAt,
    // this.updatedAt,
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
  // DateTime? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  dynamic requireNote;
  int? timezone;
  dynamic phoneAuth;
  bool? isPhoneAuthActivated;
  String? createdAt;
  // DateTime? updatedAt;
  dynamic deletedAt;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FavoriteTutor {
  FavoriteTutor({
    this.id,
    this.firstId,
    this.secondId,
    this.createdAt,
    // this.updatedAt,
    this.secondInfo,
  });

  String? id;
  String? firstId;
  String? secondId;
  String? createdAt;
  // DateTime? updatedAt;
  Info? secondInfo;

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTutorFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteTutorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FeedBack {
  FeedBack({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    // this.updatedAt,
    this.firstInfo,
  });

  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  // DateTime? updatedAt;
  Info? firstInfo;

  factory FeedBack.fromJson(Map<String, dynamic> json) =>
      _$FeedBackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedBackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TutorRowItem {
  TutorRowItem({
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
    // this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    // this.createdAt,
    // this.updatedAt,
    this.deletedAt,
    this.feedbacks,
    this.id,
    this.userId,
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.resume,
    this.rating,
    this.isNative,
    this.price,
    this.isOnline,
  });

  // late bool isFavorite;

  String? level;
  String? email;
  dynamic google;
  dynamic facebook;
  dynamic apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  dynamic language;
  // DateTime? birthday;
  bool? requestPassword;
  bool? isActivated;
  dynamic isPhoneActivated;
  dynamic requireNote;
  int? timezone;
  dynamic phoneAuth;
  bool? isPhoneAuthActivated;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  dynamic deletedAt;
  List<FeedBack>? feedbacks;
  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  dynamic accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  dynamic resume;
  double? rating;
  dynamic isNative;
  int? price;
  bool? isOnline;

  factory TutorRowItem.fromJson(Map<String, dynamic> json) =>
      _$TutorRowItemFromJson(json);

  Map<String, dynamic> toJson() => _$TutorRowItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tutors {
  Tutors({
    required this.count,
    required this.rows,
  });

  int count;
  List<TutorRowItem> rows;

  factory Tutors.fromJson(Map<String, dynamic> json) => _$TutorsFromJson(json);

  Map<String, dynamic> toJson() => _$TutorsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TutorPerPage {
  TutorPerPage({
    required this.tutors,
    required this.favoriteTutor,
  });

  Tutors tutors;
  List<FavoriteTutor>? favoriteTutor;

  factory TutorPerPage.fromJson(Map<String, dynamic> json) =>
      _$TutorPerPageFromJson(json);

  Map<String, dynamic> toJson() => _$TutorPerPageToJson(this);
}
