
/// 课程数据模型
/// 
/// 存储课程的基本信息，包括：
/// - 课程基本信息
/// - 章节列表
/// - 评分信息
class CourseModel {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final String instructor;
  final String duration;
  final double rating;
  final int ratingCount;
  final List<ChapterModel> chapters;
  final String category;
  final bool isFree;
  final int viewCount;
  
  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.instructor,
    required this.duration,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.chapters = const [],
    required this.category,
    this.isFree = true,
    this.viewCount = 0,
  });
  
  /// 从JSON创建课程模型
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImage: json['coverImage'] as String,
      instructor: json['instructor'] as String,
      duration: json['duration'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['ratingCount'] as int? ?? 0,
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      category: json['category'] as String,
      isFree: json['isFree'] as bool? ?? true,
      viewCount: json['viewCount'] as int? ?? 0,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverImage': coverImage,
      'instructor': instructor,
      'duration': duration,
      'rating': rating,
      'ratingCount': ratingCount,
      'chapters': chapters.map((chapter) => chapter.toJson()).toList(),
      'category': category,
      'isFree': isFree,
      'viewCount': viewCount,
    };
  }
  
  /// 创建课程模型的副本
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImage,
    String? instructor,
    String? duration,
    double? rating,
    int? ratingCount,
    List<ChapterModel>? chapters,
    String? category,
    bool? isFree,
    int? viewCount,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      instructor: instructor ?? this.instructor,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      chapters: chapters ?? this.chapters,
      category: category ?? this.category,
      isFree: isFree ?? this.isFree,
      viewCount: viewCount ?? this.viewCount,
    );
  }
}

/// 课程章节模型
class ChapterModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String duration;
  final bool isLocked;
  
  const ChapterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.duration,
    this.isLocked = false,
  });
  
  /// 从JSON创建章节模型
  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      duration: json['duration'] as String,
      isLocked: json['isLocked'] as bool? ?? false,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'duration': duration,
      'isLocked': isLocked,
    };
  }
  
  /// 创建章节模型的副本
  ChapterModel copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? duration,
    bool? isLocked,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      duration: duration ?? this.duration,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}