class Activity {
  final String id;
  final String title;
  final String location;
  final String time;
  final int participants;
  final String image;
  final String? description;
  final String? organizer;
  final bool? isFree;
  final double? fee;
  final bool? isJoined;
  final bool? isFavorite;
  final List<String>? tags;

  Activity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.participants,
    required this.image,
    this.description,
    this.organizer,
    this.isFree = true,
    this.fee = 0.0,
    this.isJoined = false,
    this.isFavorite = false,
    this.tags,
  });
  
  /// 从JSON创建活动模型
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      time: json['time'] as String,
      participants: json['participants'] as int,
      image: json['image'] as String,
      description: json['description'] as String?,
      organizer: json['organizer'] as String?,
      isFree: json['isFree'] as bool? ?? true,
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      isJoined: json['isJoined'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'time': time,
      'participants': participants,
      'image': image,
      'description': description,
      'organizer': organizer,
      'isFree': isFree,
      'fee': fee,
      'isJoined': isJoined,
      'isFavorite': isFavorite,
      'tags': tags,
    };
  }
  
  /// 创建活动模型的副本
  Activity copyWith({
    String? id,
    String? title,
    String? location,
    String? time,
    int? participants,
    String? image,
    String? description,
    String? organizer,
    bool? isFree,
    double? fee,
    bool? isJoined,
    bool? isFavorite,
    List<String>? tags,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      time: time ?? this.time,
      participants: participants ?? this.participants,
      image: image ?? this.image,
      description: description ?? this.description,
      organizer: organizer ?? this.organizer,
      isFree: isFree ?? this.isFree,
      fee: fee ?? this.fee,
      isJoined: isJoined ?? this.isJoined,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }
}