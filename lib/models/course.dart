import 'package:json_annotation/json_annotation.dart';
part 'course.g.dart';

@JsonSerializable(explicitToJson: true)
class Topic {
  Topic({
    this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.nameFile,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  String? description;
  dynamic videoUrl;
  String? createdAt;
  String? updatedAt;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Category {
  Category({
    this.id,
    this.title,
    this.description,
    this.key,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  dynamic description;
  String? key;
  String? createdAt;
  String? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}


@JsonSerializable(explicitToJson: true)
class CousreRowItem {
  CousreRowItem({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  dynamic courseType;
  dynamic sectionType;
  bool? visible;
  String? createdAt;
  String? updatedAt;
  List<Topic>? topics;
  List<Category>? categories;

  factory CousreRowItem.fromJson(Map<String, dynamic> json) =>
      _$CousreRowItemFromJson(json);

  Map<String, dynamic> toJson() => _$CousreRowItemToJson(this);
}


@JsonSerializable(explicitToJson: true)
class CoursePerPage {
  CoursePerPage({
    this.count,
    this.rows,
  });

  int? count;
  List<CousreRowItem>? rows;

  factory CoursePerPage.fromJson(Map<String, dynamic> json) =>
      _$CoursePerPageFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePerPageToJson(this);
}


