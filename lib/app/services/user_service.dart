import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// 用户服务
/// 
/// 处理用户相关的业务逻辑，包括：
/// - 用户认证（登录、注册、找回密码）
/// - 用户信息管理
/// - 用户积分管理
class UserService {
  // 单例模式
  static final UserService _instance = UserService._internal();
  
  factory UserService() {
    return _instance;
  }
  
  UserService._internal();
  
  // 当前登录用户
  UserModel? _currentUser;
  
  // 获取当前用户
  UserModel? get currentUser => _currentUser;
  
  // 判断用户是否已登录
  bool get isLoggedIn => _currentUser != null;
  
  // 初始化用户服务
  Future<void> init() async {
    await _loadUserFromLocal();
  }
  
  // 从本地存储加载用户信息
  Future<void> _loadUserFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      
      if (userJson != null) {
        final userData = json.decode(userJson) as Map<String, dynamic>;
        _currentUser = UserModel.fromJson(userData);
      }
    } catch (e) {
      print('加载用户信息失败: $e');
    }
  }
  
  // 保存用户信息到本地存储
  Future<void> _saveUserToLocal(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(user.toJson()));
    } catch (e) {
      print('保存用户信息失败: $e');
    }
  }
  
  // 用户登录
  Future<UserModel> login(String phone, String password) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟用户数据
    final user = UserModel(
      id: '1',
      name: '张大爷',
      phone: phone,
      email: 'zhang@example.com',
      avatar: 'assets/images/avatar1.jpg',
      points: 120,
      level: 3,
      completedCourses: ['1', '2', '3'],
      favoriteCourses: ['4', '5'],
    );
    
    // 保存当前用户
    _currentUser = user;
    await _saveUserToLocal(user);
    
    return user;
  }
  
  // 用户注册
  Future<UserModel> register(String name, String phone, String password) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟用户数据
    final user = UserModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      phone: phone,
      points: 10, // 新用户初始积分
      level: 1,
    );
    
    // 保存当前用户
    _currentUser = user;
    await _saveUserToLocal(user);
    
    return user;
  }
  
  // 用户登出
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
  
  // 更新用户信息
  Future<UserModel> updateUserInfo({
    String? name,
    String? avatar,
    String? email,
  }) async {
    if (_currentUser == null) {
      throw Exception('用户未登录');
    }
    
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 更新用户信息
    final updatedUser = _currentUser!.copyWith(
      name: name,
      avatar: avatar,
      email: email,
    );
    
    // 保存更新后的用户信息
    _currentUser = updatedUser;
    await _saveUserToLocal(updatedUser);
    
    return updatedUser;
  }
  
  // 添加积分
  Future<UserModel> addPoints(int points) async {
    if (_currentUser == null) {
      throw Exception('用户未登录');
    }
    
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 更新用户积分
    final updatedUser = _currentUser!.copyWith(
      points: _currentUser!.points + points,
    );
    
    // 保存更新后的用户信息
    _currentUser = updatedUser;
    await _saveUserToLocal(updatedUser);
    
    return updatedUser;
  }
  
  // 重置密码
  Future<bool> resetPassword(String phone, String newPassword) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟重置密码成功
    return true;
  }
  
  // 发送验证码
  Future<bool> sendVerificationCode(String phone) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟发送验证码成功
    return true;
  }
  
  // 验证验证码
  Future<bool> verifyCode(String phone, String code) async {
    // TODO: 实现真实的API调用
    // 模拟API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟验证成功
    return code == '123456'; // 假设正确的验证码是123456
  }
}