import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course_model.dart';

/// 课程服务
/// 
/// 处理课程相关的业务逻辑，包括：
/// - 获取课程列表
/// - 获取课程详情
/// - 管理学习记录
/// - 收藏课程
class CourseService {
  // 单例模式
  static final CourseService _instance = CourseService._internal();
  
  factory CourseService() {
    return _instance;
  }
  
  CourseService._internal();
  
  // 获取推荐课程列表
  Future<List<CourseModel>> getRecommendedCourses() async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟课程数据
    return [
      const CourseModel(
        id: '1',
        title: '智能手机基础操作',
        description: '本课程专为老年人设计，通过简单易懂的讲解和演示，帮助您掌握智能手机的基本操作。',
        coverImage: 'assets/images/course1.jpg',
        instructor: '王老师',
        duration: '2小时30分钟',
        rating: 4.8,
        ratingCount: 126,
        category: '科技使用',
        chapters: [
          ChapterModel(
            id: '1-1',
            title: '第一章：开机与解锁',
            description: '学习如何开启手机并解锁屏幕',
            videoUrl: 'assets/videos/smartphone_basics_1.mp4',
            duration: '15分钟',
          ),
          ChapterModel(
            id: '1-2',
            title: '第二章：触摸屏操作',
            description: '掌握点击、滑动等基本手势',
            videoUrl: 'assets/videos/smartphone_basics_2.mp4',
            duration: '20分钟',
          ),
        ],
      ),
      const CourseModel(
        id: '2',
        title: '微信使用教程',
        description: '学习如何使用微信与家人朋友保持联系，包括发送消息、语音通话和视频聊天。',
        coverImage: 'assets/images/course2.jpg',
        instructor: '李老师',
        duration: '3小时15分钟',
        rating: 4.9,
        ratingCount: 208,
        category: '社交应用',
        chapters: [
          ChapterModel(
            id: '2-1',
            title: '第一章：微信注册与登录',
            description: '学习如何注册微信账号并登录',
            videoUrl: 'assets/videos/wechat_1.mp4',
            duration: '18分钟',
          ),
          ChapterModel(
            id: '2-2',
            title: '第二章：添加好友',
            description: '学习如何添加和管理微信好友',
            videoUrl: 'assets/videos/wechat_2.mp4',
            duration: '22分钟',
          ),
        ],
      ),
    ];
  }
  
  // 获取课程分类列表
  Future<List<String>> getCourseCategories() async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(milliseconds: 500));
    
    // 模拟分类数据
    return [
      '健康养生',
      '科技使用',
      '社交应用',
      '生活技能',
      '兴趣爱好',
      '文化艺术',
    ];
  }
  
  // 根据分类获取课程列表
  Future<List<CourseModel>> getCoursesByCategory(String category) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟课程数据
    if (category == '健康养生') {
      return [
        const CourseModel(
          id: '3',
          title: '每日健康操',
          description: '适合老年人的简单健身操，每天15分钟，强健体魄。',
          coverImage: 'assets/images/course3.jpg',
          instructor: '张教练',
          duration: '1小时45分钟',
          rating: 4.7,
          ratingCount: 156,
          category: '健康养生',
        ),
        const CourseModel(
          id: '4',
          title: '中医养生知识',
          description: '传统中医养生方法详解，助您健康长寿。',
          coverImage: 'assets/images/course4.jpg',
          instructor: '陈医师',
          duration: '4小时20分钟',
          rating: 4.9,
          ratingCount: 189,
          category: '健康养生',
        ),
      ];
    } else if (category == '科技使用') {
      return [
        const CourseModel(
          id: '1',
          title: '智能手机基础操作',
          description: '本课程专为老年人设计，通过简单易懂的讲解和演示，帮助您掌握智能手机的基本操作。',
          coverImage: 'assets/images/course1.jpg',
          instructor: '王老师',
          duration: '2小时30分钟',
          rating: 4.8,
          ratingCount: 126,
          category: '科技使用',
        ),
        const CourseModel(
          id: '5',
          title: '网上购物指南',
          description: '学习如何在手机上安全地进行网上购物。',
          coverImage: 'assets/images/course5.jpg',
          instructor: '赵老师',
          duration: '2小时10分钟',
          rating: 4.6,
          ratingCount: 112,
          category: '科技使用',
        ),
      ];
    } else {
      // 返回空列表或其他分类的课程
      return [];
    }
  }
  
  // 获取课程详情
  Future<CourseModel> getCourseDetail(String courseId) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟课程详情数据
    if (courseId == '1') {
      return const CourseModel(
        id: '1',
        title: '智能手机基础操作',
        description: '本课程专为老年人设计，通过简单易懂的讲解和演示，帮助您掌握智能手机的基本操作。从开机、解锁到使用常用应用，全面覆盖日常使用场景。',
        coverImage: 'assets/images/course1.jpg',
        instructor: '王老师',
        duration: '2小时30分钟',
        rating: 4.8,
        ratingCount: 126,
        category: '科技使用',
        chapters: [
          ChapterModel(
            id: '1-1',
            title: '第一章：开机与解锁',
            description: '学习如何开启手机并解锁屏幕',
            videoUrl: 'assets/videos/smartphone_basics_1.mp4',
            duration: '15分钟',
          ),
          ChapterModel(
            id: '1-2',
            title: '第二章：触摸屏操作',
            description: '掌握点击、滑动等基本手势',
            videoUrl: 'assets/videos/smartphone_basics_2.mp4',
            duration: '20分钟',
          ),
          ChapterModel(
            id: '1-3',
            title: '第三章：主屏幕与应用',
            description: '了解主屏幕布局和应用图标',
            videoUrl: 'assets/videos/smartphone_basics_3.mp4',
            duration: '25分钟',
          ),
          ChapterModel(
            id: '1-4',
            title: '第四章：拨打电话',
            description: '学习如何拨打和接听电话',
            videoUrl: 'assets/videos/smartphone_basics_4.mp4',
            duration: '18分钟',
          ),
          ChapterModel(
            id: '1-5',
            title: '第五章：发送短信',
            description: '掌握发送和接收短信的方法',
            videoUrl: 'assets/videos/smartphone_basics_5.mp4',
            duration: '22分钟',
          ),
        ],
      );
    } else {
      // 返回默认课程或抛出异常
      throw Exception('未找到课程');
    }
  }
  
  // 记录学习进度
  Future<void> saveProgress(String courseId, String chapterId, double progress) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'progress_${courseId}_$chapterId';
      await prefs.setDouble(key, progress);
    } catch (e) {
      print('保存学习进度失败: $e');
    }
  }
  
  // 获取学习进度
  Future<double> getProgress(String courseId, String chapterId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'progress_${courseId}_$chapterId';
      return prefs.getDouble(key) ?? 0.0;
    } catch (e) {
      print('获取学习进度失败: $e');
      return 0.0;
    }
  }
  
  // 收藏课程
  Future<void> favoriteCourse(String courseId, bool isFavorite) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('favorite_courses') ?? '[]';
      final favorites = List<String>.from(json.decode(favoritesJson));
      
      if (isFavorite && !favorites.contains(courseId)) {
        favorites.add(courseId);
      } else if (!isFavorite && favorites.contains(courseId)) {
        favorites.remove(courseId);
      }
      
      await prefs.setString('favorite_courses', json.encode(favorites));
    } catch (e) {
      print('收藏课程失败: $e');
    }
  }
  
  // 检查课程是否已收藏
  Future<bool> isFavoriteCourse(String courseId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('favorite_courses') ?? '[]';
      final favorites = List<String>.from(json.decode(favoritesJson));
      return favorites.contains(courseId);
    } catch (e) {
      print('检查收藏状态失败: $e');
      return false;
    }
  }
  
  // 获取收藏的课程列表
  Future<List<String>> getFavoriteCourses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('favorite_courses') ?? '[]';
      return List<String>.from(json.decode(favoritesJson));
    } catch (e) {
      print('获取收藏课程列表失败: $e');
      return [];
    }
  }
}