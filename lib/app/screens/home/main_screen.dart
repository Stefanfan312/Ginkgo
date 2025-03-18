import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../home/home_page.dart';
import '../learn/learn_screen.dart';
import '../profile/profile_screen.dart';
import '../qa/qa_screen.dart';
import '../../services/user_service.dart';

/// 主屏幕
/// 
/// 应用的主要界面，包含底部导航栏和各个主要功能页面
/// - 首页：展示推荐内容和快捷功能
/// - 学习中心：提供课程学习功能
/// - 个人中心：管理个人信息和设置
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final UserService _userService = UserService();
  
  // 页面列表
  late final List<Widget> _pages;
  
  @override
  void initState() {
    super.initState();
    _initPages();
    _initUserService();
  }
  
  // 初始化页面列表
  void _initPages() {
    _pages = [
      const HomePage(),
      const LearnScreen(),
      const QAScreen(),
      const ProfileScreen(),
    ];
  }
  
  // 初始化用户服务
  Future<void> _initUserService() async {
    await _userService.init();
    // 如果用户未登录，跳转到登录页面
    if (!_userService.isLoggedIn) {
      if (mounted) {
        context.go('/login');
      }
    }
  }
  
  // 底部导航项定义
  final List<BottomNavigationBarItem> _navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.school_rounded),
      label: '学习',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.question_answer_rounded),
      label: '提问',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: '我的',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navigationItems,
        // 适合老年人的底部导航栏样式
        type: BottomNavigationBarType.fixed,
        selectedFontSize: AppTheme.fontSizeSmall,
        unselectedFontSize: AppTheme.fontSizeSmall,
        iconSize: AppTheme.iconSizeMedium,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        elevation: 8,
      ),
    );
  }
}