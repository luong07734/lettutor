// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorDetail _$TutorDetailFromJson(Map<String, dynamic> json) => TutorDetail(
      video: json['video'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      experience: json['experience'] as String?,
      profession: json['profession'] as String?,
      accent: json['accent'],
      targetStudent: json['targetStudent'] as String?,
      interests: json['interests'] as String?,
      languages: json['languages'] as String?,
      specialties: json['specialties'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isNative: json['isNative'],
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool?,
      avgRating: (json['avgRating'] as num?)?.toDouble(),
      totalFeedback: json['totalFeedback'] as int?,
    );

Map<String, dynamic> _$TutorDetailToJson(TutorDetail instance) =>
    <String, dynamic>{
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'accent': instance.accent,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'rating': instance.rating,
      'isNative': instance.isNative,
      'user': instance.user?.toJson(),
      'isFavorite': instance.isFavorite,
      'avgRating': instance.avgRating,
      'totalFeedback': instance.totalFeedback,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      level: json['level'] as String?,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      language: json['language'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'language': instance.language,
      'courses': instance.courses?.map((e) => e.toJson()).toList(),
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String?,
      name: json['name'] as String?,
      tutorCourse:
          TutorCourse.fromJson(json['tutorCourse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tutorCourse': instance.tutorCourse.toJson(),
    };

TutorCourse _$TutorCourseFromJson(Map<String, dynamic> json) => TutorCourse(
      userId: json['userId'] as String?,
      courseId: json['courseId'] as String?,
    );

Map<String, dynamic> _$TutorCourseToJson(TutorCourse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'courseId': instance.courseId,
    };
