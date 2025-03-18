import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'activity_list_screen.dart';

/// 社交模块主页面
/// 
/// 整合社区活动、交友互动等社交功能，包括：
/// - 活动列表
/// - 社区论坛
/// - 兴趣小组
/// - 志愿服务
class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '社交',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          indicatorWeight: 3,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          labelStyle: const TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: AppTheme.fontSizeSmall,
          ),
          tabs: const [
            Tab(text: '活动'),
            Tab(text: '论坛'),
            Tab(text: '小组'),
            Tab(text: '志愿'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 活动列表页面
          const ActivityListScreen(),
          
          // 论坛页面（待实现）
          _buildComingSoonPage('社区论坛'),
          
          // 兴趣小组页面（待实现）
          _buildComingSoonPage('兴趣小组'),
          
          // 志愿服务页面（待实现）
          _buildComingSoonPage('志愿服务'),
        ],
      ),
    );
  }
  
  // 构建即将上线的页面
  Widget _buildComingSoonPage(String feature) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.engineering,
            size: AppTheme.iconSizeLarge,
            color: Colors.grey,
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Text(
            '$feature功能',
            style: const TextStyle(
              fontSize: AppTheme.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          const Text(
            '正在开发中，敬请期待...',
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}