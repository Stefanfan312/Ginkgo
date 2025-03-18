import 'package:flutter/material.dart';
import '../../models/activity.dart';
import '../../services/activity_service.dart';
import '../../theme/app_theme.dart';
import '../social/activity_detail_screen.dart';

/// 用户活动页面
/// 
/// 展示用户已参与和收藏的活动，包括：
/// - 已参与的活动
/// - 已收藏的活动
class UserActivitiesScreen extends StatefulWidget {
  final String userId;
  final String initialTab; // 'joined' 或 'favorite'
  
  const UserActivitiesScreen({
    super.key,
    required this.userId,
    this.initialTab = 'joined',
  });

  @override
  State<UserActivitiesScreen> createState() => _UserActivitiesScreenState();
}

class _UserActivitiesScreenState extends State<UserActivitiesScreen> with SingleTickerProviderStateMixin {
  final ActivityService _activityService = ActivityService();
  late TabController _tabController;
  late Future<List<Activity>> _joinedActivitiesFuture;
  late Future<List<Activity>> _favoriteActivitiesFuture;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == 'joined' ? 0 : 1,
    );
    _loadActivities();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // 加载活动数据
  void _loadActivities() {
    _joinedActivitiesFuture = _activityService.getUserActivities(widget.userId);
    _favoriteActivitiesFuture = _activityService.getFavoriteActivities(widget.userId);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '我的活动',
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
            Tab(text: '已参与'),
            Tab(text: '已收藏'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 已参与的活动
          _buildActivitiesList(_joinedActivitiesFuture, '您还没有参与任何活动'),
          
          // 已收藏的活动
          _buildActivitiesList(_favoriteActivitiesFuture, '您还没有收藏任何活动'),
        ],
      ),
    );
  }
  
  // 构建活动列表
  Widget _buildActivitiesList(Future<List<Activity>> activitiesFuture, String emptyMessage) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _loadActivities();
        });
      },
      child: FutureBuilder<List<Activity>>(
        future: activitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '加载失败：${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.event_busy,
                    size: AppTheme.iconSizeLarge,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    emptyMessage,
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLarge),
                  ElevatedButton(
                    onPressed: () {
                      // 导航到活动列表页面
                      Navigator.pushNamed(context, '/social');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingLarge,
                        vertical: AppTheme.spacingMedium,
                      ),
                    ),
                    child: const Text(
                      '去看看活动',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          
          final activities = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _buildActivityCard(activity);
            },
          );
        },
      ),
    );
  }
  
  // 构建活动卡片
  Widget _buildActivityCard(Activity activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: InkWell(
        onTap: () {
          // 导航到活动详情页面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityDetailScreen(activityId: activity.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 活动图片
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.borderRadius),
                topRight: Radius.circular(AppTheme.borderRadius),
              ),
              child: Image.asset(
                activity.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            // 活动信息
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 活动标题
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  
                  // 活动时间和地点
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity.time,
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMedium),
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          activity.location,
                          style: const TextStyle(
                            fontSize: AppTheme.fontSizeSmall,
                            color: AppTheme.textSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  
                  // 参与人数
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${activity.participants}人参与',
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
          ],
        ),
      ),
    );
  }
}