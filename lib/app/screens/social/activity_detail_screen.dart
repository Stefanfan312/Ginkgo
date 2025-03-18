import 'package:flutter/material.dart';
import '../../models/activity.dart';
import '../../services/activity_service.dart';
import '../../theme/app_theme.dart';

/// 活动详情页面
/// 
/// 展示活动的详细信息，包括：
/// - 活动标题、时间、地点
/// - 活动描述
/// - 参与人数
/// - 报名按钮
/// - 收藏功能
class ActivityDetailScreen extends StatefulWidget {
  final String activityId;
  
  const ActivityDetailScreen({super.key, required this.activityId});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  final ActivityService _activityService = ActivityService();
  late Future<Activity> _activityFuture;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadActivityDetail();
  }
  
  // 加载活动详情
  void _loadActivityDetail() {
    _activityFuture = _activityService.getActivityDetail(widget.activityId);
  }
  
  // 报名参加活动
  Future<void> _joinActivity() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final success = await _activityService.joinActivity(widget.activityId);
      if (success && mounted) {
        // 重新加载活动详情，更新状态
        setState(() {
          _loadActivityDetail();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('报名成功！')),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('报名失败：$e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  // 收藏/取消收藏活动
  Future<void> _toggleFavorite(Activity activity) async {
    try {
      final newStatus = !(activity.isFavorite ?? false);
      final success = await _activityService.favoriteActivity(
        widget.activityId, 
        newStatus,
      );
      
      if (success && mounted) {
        // 重新加载活动详情，更新状态
        setState(() {
          _loadActivityDetail();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(newStatus ? '已添加到收藏' : '已取消收藏'),
              duration: const Duration(seconds: 1),
            ),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败：$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Activity>(
        future: _activityFuture,
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
          } else if (!snapshot.hasData) {
            return const Center(child: Text('未找到活动信息'));
          }
          
          final activity = snapshot.data!;
          return CustomScrollView(
            slivers: [
              // 顶部图片和返回按钮
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    activity.image,
                    fit: BoxFit.cover,
                  ),
                ),
                leading: IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: Icon(
                        activity.isFavorite ?? false
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: activity.isFavorite ?? false
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    onPressed: () => _toggleFavorite(activity),
                  ),
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: Icon(Icons.share, color: Colors.black),
                    ),
                    onPressed: () {
                      // TODO: 实现分享功能
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('分享功能开发中...')),
                      );
                    },
                  ),
                ],
              ),
              
              // 活动内容
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 活动标题
                      Text(
                        activity.title,
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMedium),
                      
                      // 活动信息卡片
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.spacingMedium),
                          child: Column(
                            children: [
                              // 时间信息
                              _buildInfoRow(
                                Icons.access_time,
                                '活动时间',
                                activity.time,
                              ),
                              const Divider(),
                              
                              // 地点信息
                              _buildInfoRow(
                                Icons.location_on,
                                '活动地点',
                                activity.location,
                              ),
                              const Divider(),
                              
                              // 组织者信息
                              _buildInfoRow(
                                Icons.people,
                                '组织者',
                                activity.organizer ?? '社区服务中心',
                              ),
                              const Divider(),
                              
                              // 参与人数
                              _buildInfoRow(
                                Icons.group,
                                '已报名人数',
                                '${activity.participants}人',
                              ),
                              
                              // 费用信息
                              if (activity.isFree != null)
                                Column(
                                  children: [
                                    const Divider(),
                                    _buildInfoRow(
                                      Icons.attach_money,
                                      '活动费用',
                                      activity.isFree! ? '免费' : '¥${activity.fee}',
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: AppTheme.spacingLarge),
                      
                      // 活动描述
                      const Text(
                        '活动详情',
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMedium),
                      Text(
                        activity.description ?? '暂无活动详情',
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          height: 1.5,
                        ),
                      ),
                      
                      // 活动标签
                      if (activity.tags != null && activity.tags!.isNotEmpty) ...[  
                        const SizedBox(height: AppTheme.spacingLarge),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: activity.tags!.map((tag) {
                            return Chip(
                              label: Text(
                                tag,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                            );
                          }).toList(),
                        ),
                      ],
                      
                      const SizedBox(height: AppTheme.spacingLarge * 2),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: FutureBuilder<Activity>(
        future: _activityFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          
          final activity = snapshot.data!;
          final bool isJoined = activity.isJoined ?? false;
          
          return Container(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // 收藏按钮
                IconButton(
                  icon: Icon(
                    activity.isFavorite ?? false
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: activity.isFavorite ?? false
                        ? Colors.red
                        : Colors.grey,
                    size: AppTheme.iconSizeMedium,
                  ),
                  onPressed: () => _toggleFavorite(activity),
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                
                // 报名按钮
                Expanded(
                  child: ElevatedButton(
                    onPressed: isJoined || _isLoading ? null : _joinActivity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isJoined
                          ? Colors.grey
                          : AppTheme.primaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            isJoined ? '已报名' : '立即报名',
                            style: const TextStyle(
                              fontSize: AppTheme.fontSizeMedium,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // 构建信息行
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.secondaryColor, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}