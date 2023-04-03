import 'package:json_annotation/json_annotation.dart';
part 'tutor_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TutorDetail {
  TutorDetail({
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.accent,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    required this.rating,
    required this.isNative,
    required this.user,
    required this.isFavorite,
    required this.avgRating,
    required this.totalFeedback,
  });

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

  double? rating;
  dynamic? isNative;
  User? user;
  bool? isFavorite;
  double? avgRating;
  int? totalFeedback;

    factory TutorDetail.fromJson(Map<String, dynamic> json) =>
      _$TutorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TutorDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User {
  User({
    required this.id,
    required this.level,
    required this.avatar,
    required this.name,
    required this.country,
    required this.language,
    required this.courses,
  });

  String? id;
  String? level;

  String? avatar;
  String? name;
  String? country;

  String? language;

  List<Course>? courses;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Course {
  Course({
    required this.id,
    required this.name,
    required this.tutorCourse,
  });

  String? id;
  String? name;

  TutorCourse tutorCourse;

    factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TutorCourse {
  TutorCourse({
    required this.userId,
    required this.courseId,
    // required this.createdAt,
    // required this.updatedAt,
  });

  String? userId;
  String? courseId;
  // DateTime createdAt;
  // DateTime updatedAt;


    factory TutorCourse.fromJson(Map<String, dynamic> json) =>
      _$TutorCourseFromJson(json);

  Map<String, dynamic> toJson() => _$TutorCourseToJson(this);
}
