
/// 用户数据模型
/// 
/// 存储用户的基本信息，包括：
/// - 个人资料
/// - 学习记录
/// - 积分信息
class UserModel {
  final String id;
  final String name;
  final String? avatar;
  final String? phone;
  final String? email;
  final int points;
  final int level;
  final List<String> completedCourses;
  final List<String> favoriteCourses;
  
  const UserModel({
    required this.id,
    required this.name,
    this.avatar,
    this.phone,
    this.email,
    this.points = 0,
    this.level = 1,
    this.completedCourses = const [],
    this.favoriteCourses = const [],
  });
  
  /// 从JSON创建用户模型
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      points: json['points'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      completedCourses: (json['completedCourses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      favoriteCourses: (json['favoriteCourses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'points': points,
      'level': level,
      'completedCourses': completedCourses,
      'favoriteCourses': favoriteCourses,
    };
  }
  
  /// 创建用户模型的副本
  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? phone,
    String? email,
    int? points,
    int? level,
    List<String>? completedCourses,
    List<String>? favoriteCourses,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      points: points ?? this.points,
      level: level ?? this.level,
      completedCourses: completedCourses ?? this.completedCourses,
      favoriteCourses: favoriteCourses ?? this.favoriteCourses,
    );
  }
}