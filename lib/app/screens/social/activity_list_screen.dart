import 'package:flutter/material.dart';
import '../../models/activity.dart';
import '../../services/activity_service.dart';
import '../../theme/app_theme.dart';
import 'activity_detail_screen.dart';

/// 活动列表页面
/// 
/// 展示所有可参与的活动，包括：
/// - 热门活动
/// - 附近活动
/// - 活动分类
/// - 搜索功能
class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({super.key});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  final ActivityService _activityService = ActivityService();
  late Future<List<Activity>> _activitiesFuture;
  String _selectedCategory = '全部';
  
  // 活动分类列表
  final List<String> _categories = [
    '全部',
    '健康讲座',
    '文化活动',
    '技能培训',
    '户外活动',
    '志愿服务',
  ];
  
  @override
  void initState() {
    super.initState();
    _loadActivities();
  }
  
  // 加载活动列表
  void _loadActivities() {
    _activitiesFuture = _activityService.getPopularActivities();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '社区活动',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: AppTheme.iconSizeMedium),
            onPressed: () {
              // TODO: 实现活动搜索功能
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('搜索功能开发中...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 分类选择器
          _buildCategorySelector(),
          
          // 活动列表
          Expanded(
            child: FutureBuilder<List<Activity>>(
              future: _activitiesFuture,
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
                  return const Center(child: Text('暂无活动信息'));
                }
                
                final activities = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _loadActivities();
                    });
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return _buildActivityCard(activities[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现活动筛选功能
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('筛选功能开发中...')),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.filter_list, color: Colors.black),
      ),
    );
  }
  
  // 构建分类选择器
  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                // TODO: 根据分类筛选活动
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey.shade700,
                ),
              ),
            ),
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
                  const SizedBox(height: 8),
                  
                  // 活动时间
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
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // 活动地点
                  Row(
                    children: [
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
                  const SizedBox(height: 8),
                  
                  // 参与人数和收藏按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '已有${activity.participants}人报名',
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      Icon(
                        activity.isFavorite ?? false
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: activity.isFavorite ?? false
                            ? Colors.red
                            : Colors.grey,
                        size: 20,
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