import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

/// 主页屏幕
/// 
/// 包含底部导航栏，用于在应用的主要功能模块之间切换：
/// - 首页
/// - 学习中心
/// - 个人中心
class HomeScreen extends StatefulWidget {
  final int initialTabIndex;
  final Widget child;
  
  const HomeScreen({
    super.key,
    required this.child,
    this.initialTabIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
  }
  
  // 底部导航项定义
  final List<_NavigationItem> _navigationItems = [
    const _NavigationItem(
      icon: Icons.home_rounded,
      label: '首页',
      location: '/',
    ),
    const _NavigationItem(
      icon: Icons.school_rounded,
      label: '学习',
      location: '/learn',
    ),
    const _NavigationItem(
      icon: Icons.person_rounded,
      label: '我的',
      location: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
            // 使用GoRouter导航到对应页面
            context.go(_navigationItems[index].location);
          }
        },
        items: _navigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
        // 适合老年人的底部导航栏样式
        type: BottomNavigationBarType.fixed,
        selectedFontSize: AppTheme.fontSizeSmall,
        unselectedFontSize: AppTheme.fontSizeSmall,
        iconSize: AppTheme.iconSizeMedium,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
      ),
    );
  }
}

/// 导航项数据模型
class _NavigationItem {
  final IconData icon;
  final String label;
  final String location;

  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.location,
  });
}