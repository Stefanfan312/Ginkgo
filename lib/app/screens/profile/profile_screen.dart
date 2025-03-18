import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'user_activities_screen.dart';

/// 个人中心页面
/// 
/// 为老年人提供个人信息管理功能，包括：
/// - 个人资料
/// - 健康数据
/// - 学习记录
/// - 系统设置
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '个人中心',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: AppTheme.iconSizeMedium),
            onPressed: () {
              // 导航到设置页面
              Navigator.pushNamed(context, '/profile/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息卡片
            _buildUserInfoCard(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 健康数据
            _buildSectionTitle('健康数据'),
            _buildHealthDataCard(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 功能菜单
            _buildSectionTitle('我的服务'),
            _buildMenuGrid(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 学习记录
            _buildSectionTitle('学习记录'),
            _buildLearningRecords(),
          ],
        ),
      ),
    );
  }
  
  // 构建用户信息卡片
  Widget _buildUserInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Row(
          children: [
            // 用户头像
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            // 用户信息
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '张大爷',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '手机号: 138****6789',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeSmall,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppTheme.primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '银杏会员',
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 编辑按钮
            ElevatedButton(
              onPressed: () {
                // TODO: 导航到编辑个人资料页面
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMedium,
                  vertical: AppTheme.spacingSmall,
                ),
              ),
              child: const Text(
                '编辑资料',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // 构建健康数据卡片
  Widget _buildHealthDataCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHealthDataItem(
                  icon: Icons.directions_walk,
                  title: '今日步数',
                  value: '3,256',
                  unit: '步',
                ),
                _buildHealthDataItem(
                  icon: Icons.favorite,
                  title: '心率',
                  value: '72',
                  unit: '次/分',
                ),
                _buildHealthDataItem(
                  icon: Icons.nightlight_round,
                  title: '睡眠',
                  value: '7.5',
                  unit: '小时',
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: 导航到健康数据详情页面
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryColor),
                  foregroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
                ),
                child: const Text(
                  '查看详情',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // 构建健康数据项
  Widget _buildHealthDataItem({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.secondaryColor,
          size: AppTheme.iconSizeMedium,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // 构建功能菜单网格
  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.assignment,
        'title': '我的课程',
        'route': '/profile/courses',
      },
      {
        'icon': Icons.event,
        'title': '我的活动',
        'route': '/profile/activities',
        'onTap': (BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserActivitiesScreen(
                userId: 'current_user_id', // TODO: 使用真实用户ID
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.favorite,
        'title': '我的收藏',
        'route': '/profile/favorites',
        'onTap': (BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserActivitiesScreen(
                userId: 'current_user_id', // TODO: 使用真实用户ID
                initialTab: 'favorite',
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.history,
        'title': '浏览历史',
        'route': '/profile/history',
      },
      {
        'icon': Icons.card_giftcard,
        'title': '积分中心',
        'route': '/profile/points',
      },
      {
        'icon': Icons.help,
        'title': '帮助中心',
        'route': '/profile/help',
      },
      {
        'icon': Icons.feedback,
        'title': '意见反馈',
        'route': '/profile/feedback',
      },
    ];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: AppTheme.spacingMedium,
        mainAxisSpacing: AppTheme.spacingMedium,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () {
            if (item['onTap'] != null) {
              item['onTap'](context);
            } else {
              // TODO: 导航到对应页面
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'],
                  color: AppTheme.secondaryColor,
                  size: AppTheme.iconSizeMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // 构建学习记录
  Widget _buildLearningRecords() {
    final List<Map<String, dynamic>> records = [
      {
        'title': '每日健康操',
        'progress': 0.4,
        'lastTime': '昨天',
      },
      {
        'title': '智能手机入门',
        'progress': 0.7,
        'lastTime': '3天前',
      },
    ];
    
    return Column(
      children: records.map((record) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: AppTheme.primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record['title'],
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '上次学习: ${record['lastTime']}',
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeSmall,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: record['progress'],
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '完成 ${(record['progress'] * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeExtraSmall,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () {
                  // TODO: 继续学习
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  // 构建章节标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeMedium,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}