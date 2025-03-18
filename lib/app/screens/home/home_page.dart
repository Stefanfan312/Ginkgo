import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// 首页页面
/// 
/// 为老年人提供主要功能入口，包括：
/// - 健康提醒
/// - 推荐课程
/// - 热门活动
/// - 生活服务
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icons/ginkgo_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          '银杏应用',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, size: AppTheme.iconSizeMedium),
            onPressed: () {
              // TODO: 导航到消息通知页面
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 欢迎消息
            _buildWelcomeCard(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 健康提醒
            _buildSectionTitle('今日健康'),
            _buildHealthReminder(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 快捷功能
            _buildSectionTitle('快捷功能'),
            _buildQuickAccessGrid(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 推荐课程
            _buildSectionTitle('推荐课程'),
            _buildRecommendedCourses(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 热门活动
            _buildSectionTitle('热门活动'),
            _buildPopularActivities(),
          ],
        ),
      ),
    );
  }
  
  // 构建欢迎卡片
  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '下午好，张大爷',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeLarge,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '今天是个锻炼身体的好日子',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '天气：晴 26°C',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.wb_sunny,
            size: AppTheme.iconSizeLarge,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
  
  // 构建健康提醒
  Widget _buildHealthReminder() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.medical_services,
                  color: AppTheme.secondaryColor,
                  size: AppTheme.iconSizeMedium,
                ),
                SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Text(
                    '用药提醒',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '14:00',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            const Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  color: AppTheme.secondaryColor,
                  size: AppTheme.iconSizeMedium,
                ),
                SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Text(
                    '今日步数',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '2,345 步',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: 导航到健康详情页面
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.secondaryColor),
                  foregroundColor: AppTheme.secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
                ),
                child: const Text(
                  '查看更多健康数据',
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
  
  // 构建快捷功能网格
  Widget _buildQuickAccessGrid() {
    final List<Map<String, dynamic>> quickAccessItems = [
      {
        'icon': Icons.video_library,
        'title': '视频课程',
        'color': Colors.orange,
      },
      {
        'icon': Icons.people,
        'title': '社区活动',
        'color': Colors.blue,
      },
      {
        'icon': Icons.local_hospital,
        'title': '健康咨询',
        'color': Colors.green,
      },
      {
        'icon': Icons.help,
        'title': '使用帮助',
        'color': Colors.purple,
      },
    ];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        crossAxisSpacing: AppTheme.spacingSmall,
        mainAxisSpacing: AppTheme.spacingSmall,
      ),
      itemCount: quickAccessItems.length,
      itemBuilder: (context, index) {
        final item = quickAccessItems[index];
        return GestureDetector(
          onTap: () {
            // TODO: 导航到对应功能页面
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item['icon'],
                  color: item['color'],
                  size: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['title'],
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
  
  // 构建推荐课程
  Widget _buildRecommendedCourses() {
    final List<Map<String, dynamic>> courses = [
      {
        'title': '每日健康操',
        'image': 'assets/images/course1.jpg',
        'duration': '15分钟',
      },
      {
        'title': '智能手机入门',
        'image': 'assets/images/course2.jpg',
        'duration': '30分钟',
      },
    ];
    
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: AppTheme.spacingMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 课程图片
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.borderRadius),
                      topRight: Radius.circular(AppTheme.borderRadius),
                    ),
                    image: DecorationImage(
                      image: AssetImage(course['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                // 课程信息
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingSmall),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppTheme.borderRadius),
                      bottomRight: Radius.circular(AppTheme.borderRadius),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          course['title'],
                          style: const TextStyle(
                            fontSize: AppTheme.fontSizeSmall,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        course['duration'],
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeExtraSmall,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // 构建热门活动
  Widget _buildPopularActivities() {
    final List<Map<String, dynamic>> activities = [
      {
        'title': '社区健康讲座',
        'location': '阳光社区活动中心',
        'time': '明天 14:00-16:00',
        'image': 'assets/images/activity1.jpg',
      },
      {
        'title': '老年智能手机课堂',
        'location': '银杏老年大学',
        'time': '周六 09:00-11:00',
        'image': 'assets/images/activity2.jpg',
      },
    ];
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // 活动图片
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.borderRadius),
                  bottomLeft: Radius.circular(AppTheme.borderRadius),
                ),
                child: Image.asset(
                  activity['image'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              // 活动信息
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'],
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppTheme.textSecondaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              activity['location'],
                              style: const TextStyle(
                                fontSize: AppTheme.fontSizeSmall,
                                color: AppTheme.textSecondaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: AppTheme.textSecondaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            activity['time'],
                            style: const TextStyle(
                              fontSize: AppTheme.fontSizeSmall,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 箭头图标
              const Padding(
                padding: EdgeInsets.all(AppTheme.spacingMedium),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.textSecondaryColor,
                  size: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // 构建章节标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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