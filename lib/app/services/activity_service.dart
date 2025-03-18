import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';

/// 活动服务
/// 
/// 处理活动相关的业务逻辑，包括：
/// - 获取活动列表
/// - 获取活动详情
/// - 活动报名与管理
/// - 收藏活动
class ActivityService {
  // 单例模式
  static final ActivityService _instance = ActivityService._internal();
  
  factory ActivityService() {
    return _instance;
  }
  
  ActivityService._internal();

  // 本地缓存键
  static const String _popularActivitiesKey = 'popular_activities';
  static const String _userActivitiesKey = 'user_activities';
  static const String _favoriteActivitiesKey = 'favorite_activities';
  
  // 获取热门活动列表
  Future<List<Activity>> getPopularActivities() async {
    try {
      // 尝试从本地缓存获取数据
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_popularActivitiesKey);
      
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Activity.fromJson(json)).toList();
      }
      
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟活动数据
      final activities = [
        Activity(
          id: '1',
          title: '社区健康讲座',
          location: '阳光社区活动中心',
          time: '明天 14:00-16:00',
          participants: 28,
          image: 'assets/images/activity1.jpg',
        ),
        Activity(
          id: '2',
          title: '老年人智能手机使用培训',
          location: '银杏老年大学',
          time: '周六 09:00-11:00',
          participants: 42,
          image: 'assets/images/activity2.jpg',
        ),
        Activity(
          id: '3',
          title: '太极拳晨练班',
          location: '城市公园广场',
          time: '每天 06:30-08:00',
          participants: 35,
          image: 'assets/images/activity3.jpg',
        ),
        Activity(
          id: '4',
          title: '老年合唱团排练',
          location: '文化活动中心',
          time: '周三 15:00-17:00',
          participants: 24,
          image: 'assets/images/activity4.jpg',
        ),
      ];
      
      // 缓存数据
      await prefs.setString(_popularActivitiesKey, json.encode(
        activities.map((activity) => activity.toJson()).toList()
      ));
      
      return activities;
    } catch (e) {
      throw Exception('获取热门活动失败: $e');
    }
  }
  
  // 获取活动详情
  Future<Activity> getActivityDetail(String activityId) async {
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟活动详情数据
      final activities = await getPopularActivities();
      return activities.firstWhere(
        (activity) => activity.id == activityId,
        orElse: () => Activity(
          id: '0',
          title: '未找到活动',
          location: '未知',
          time: '未知',
          participants: 0,
          image: 'assets/images/placeholder.jpg',
        ),
      );
    } catch (e) {
      throw Exception('获取活动详情失败: $e');
    }
  }
  
  // 报名参加活动
  Future<bool> joinActivity(String activityId) async {
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 更新本地缓存中的用户活动列表
      final prefs = await SharedPreferences.getInstance();
      final activity = await getActivityDetail(activityId);
      final List<Activity> userActivities = await getUserActivities('');
      
      if (!userActivities.any((a) => a.id == activityId)) {
        userActivities.add(activity.copyWith(isJoined: true));
        await prefs.setString(_userActivitiesKey, json.encode(
          userActivities.map((activity) => activity.toJson()).toList()
        ));
      }
      
      return true;
    } catch (e) {
      throw Exception('活动报名失败: $e');
    }
  }
  
  // 获取用户已报名的活动
  Future<List<Activity>> getUserActivities(String userId) async {
    try {
      // 尝试从本地缓存获取数据
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_userActivitiesKey);
      
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Activity.fromJson(json)).toList();
      }
      
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟用户已报名的活动数据
      final allActivities = await getPopularActivities();
      final userActivities = allActivities.take(2).map((activity) => 
        activity.copyWith(isJoined: true)
      ).toList();
      
      // 缓存数据
      await prefs.setString(_userActivitiesKey, json.encode(
        userActivities.map((activity) => activity.toJson()).toList()
      ));
      
      return userActivities;
    } catch (e) {
      throw Exception('获取用户活动失败: $e');
    }
  }
  
  // 收藏活动
  Future<bool> favoriteActivity(String activityId, bool isFavorite) async {
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 更新本地缓存中的收藏活动列表
      final prefs = await SharedPreferences.getInstance();
      final activity = await getActivityDetail(activityId);
      final List<Activity> favoriteActivities = await getFavoriteActivities('');
      
      if (isFavorite && !favoriteActivities.any((a) => a.id == activityId)) {
        favoriteActivities.add(activity);
      } else {
        favoriteActivities.removeWhere((a) => a.id == activityId);
      }
      
      await prefs.setString(_favoriteActivitiesKey, json.encode(
        favoriteActivities.map((activity) => activity.toJson()).toList()
      ));
      
      return true;
    } catch (e) {
      throw Exception('收藏活动失败: $e');
    }
  }
  
  // 获取用户收藏的活动
  Future<List<Activity>> getFavoriteActivities(String userId) async {
    try {
      // 尝试从本地缓存获取数据
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_favoriteActivitiesKey);
      
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Activity.fromJson(json)).toList();
      }
      
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟用户收藏的活动数据
      final allActivities = await getPopularActivities();
      final favoriteActivities = allActivities.skip(2).take(2).toList();
      
      // 缓存数据
      await prefs.setString(_favoriteActivitiesKey, json.encode(
        favoriteActivities.map((activity) => activity.toJson()).toList()
      ));
      
      return favoriteActivities;
    } catch (e) {
      throw Exception('获取收藏活动失败: $e');
    }
  }
  
  // 清除本地缓存
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_popularActivitiesKey);
      await prefs.remove(_userActivitiesKey);
      await prefs.remove(_favoriteActivitiesKey);
    } catch (e) {
      throw Exception('清除缓存失败: $e');
    }
  }
}