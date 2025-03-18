import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'user_service.dart';

/// 认证服务
/// 
/// 处理用户认证相关的业务逻辑，包括：
/// - 登录（账号密码登录、短信验证码登录、第三方登录）
/// - 注册
/// - 找回密码
/// - 验证码发送与验证
class AuthService {
  // 单例模式
  static final AuthService _instance = AuthService._internal();
  
  factory AuthService() {
    return _instance;
  }
  
  AuthService._internal();
  
  final UserService _userService = UserService();
  
  // 登录状态
  bool get isLoggedIn => _userService.isLoggedIn;
  
  // 当前用户
  UserModel? get currentUser => _userService.currentUser;
  
  // 保存登录状态
  Future<void> _saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
  
  // 获取登录状态
  Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  
  // 账号密码登录
  Future<UserModel> loginWithPassword(String phone, String password) async {
    try {
      // 调用用户服务的登录方法
      final user = await _userService.login(phone, password);
      
      // 保存登录状态
      await _saveLoginState(true);
      
      return user;
    } catch (e) {
      // 登录失败，抛出异常
      throw Exception('登录失败：$e');
    }
  }
  
  // 短信验证码登录
  Future<UserModel> loginWithSmsCode(String phone, String smsCode) async {
    try {
      // 验证短信验证码
      final isValid = await verifyCode(phone, smsCode);
      
      if (!isValid) {
        throw Exception('验证码错误');
      }
      
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 查找或创建用户
      // 这里简化处理，实际应用中应该从服务器获取用户信息
      final user = await _userService.login(phone, '');
      
      // 保存登录状态
      await _saveLoginState(true);
      
      return user;
    } catch (e) {
      throw Exception('短信登录失败：$e');
    }
  }
  
  // 微信登录
  Future<UserModel> loginWithWeChat() async {
    try {
      // TODO: 实现微信登录
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟用户数据
      final user = UserModel(
        id: 'wx_${DateTime.now().millisecondsSinceEpoch}',
        name: '微信用户',
        avatar: 'assets/images/default_avatar.png',
        points: 10,
        level: 1,
      );
      
      // 保存当前用户
      // 实际应用中应该调用服务器API保存用户信息
      
      // 保存登录状态
      await _saveLoginState(true);
      
      return user;
    } catch (e) {
      throw Exception('微信登录失败：$e');
    }
  }
  
  // 用户注册
  Future<UserModel> register(String name, String phone, String password, String verificationCode) async {
    try {
      // 验证短信验证码
      final isValid = await verifyCode(phone, verificationCode);
      
      if (!isValid) {
        throw Exception('验证码错误');
      }
      
      // 调用用户服务的注册方法
      final user = await _userService.register(name, phone, password);
      
      // 保存登录状态
      await _saveLoginState(true);
      
      return user;
    } catch (e) {
      throw Exception('注册失败：$e');
    }
  }
  
  // 退出登录
  Future<void> logout() async {
    try {
      await _userService.logout();
      await _saveLoginState(false);
    } catch (e) {
      throw Exception('退出登录失败：$e');
    }
  }
  
  // 发送验证码
  Future<bool> sendVerificationCode(String phone) async {
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟发送验证码成功
      return true;
    } catch (e) {
      throw Exception('发送验证码失败：$e');
    }
  }
  
  // 验证验证码
  Future<bool> verifyCode(String phone, String code) async {
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟验证成功
      return code == '123456'; // 假设正确的验证码是123456
    } catch (e) {
      throw Exception('验证码验证失败：$e');
    }
  }
  
  // 重置密码
  Future<bool> resetPassword(String phone, String verificationCode, String newPassword) async {
    try {
      // 验证短信验证码
      final isValid = await verifyCode(phone, verificationCode);
      
      if (!isValid) {
        throw Exception('验证码错误');
      }
      
      // 调用用户服务的重置密码方法
      return await _userService.resetPassword(phone, newPassword);
    } catch (e) {
      throw Exception('重置密码失败：$e');
    }
  }
}