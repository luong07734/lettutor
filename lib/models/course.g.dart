// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as String?,
      courseId: json['courseId'] as String?,
      orderCourse: json['orderCourse'] as int?,
      name: json['name'] as String?,
      nameFile: json['nameFile'] as String?,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'orderCourse': instance.orderCourse,
      'name': instance.name,
      'nameFile': instance.nameFile,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'],
      key: json['key'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'key': instance.key,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CousreRowItem _$CousreRowItemFromJson(Map<String, dynamic> json) =>
    CousreRowItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: json['level'] as String?,
      reason: json['reason'] as String?,
      purpose: json['purpose'] as String?,
      otherDetails: json['otherDetails'] as String?,
      defaultPrice: json['defaultPrice'] as int?,
      coursePrice: json['coursePrice'] as int?,
      courseType: json['courseType'],
      sectionType: json['sectionType'],
      visible: json['visible'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CousreRowItemToJson(CousreRowItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'level': instance.level,
      'reason': instance.reason,
      'purpose': instance.purpose,
      'otherDetails': instance.otherDetails,
      'defaultPrice': instance.defaultPrice,
      'coursePrice': instance.coursePrice,
      'courseType': instance.courseType,
      'sectionType': instance.sectionType,
      'visible': instance.visible,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'topics': instance.topics?.map((e) => e.toJson()).toList(),
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
    };

CoursePerPage _$CoursePerPageFromJson(Map<String, dynamic> json) =>
    CoursePerPage(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => CousreRowItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursePerPageToJson(CoursePerPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
    };
