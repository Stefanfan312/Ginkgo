import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../qa/qa_list_screen.dart';
import 'course_detail_screen.dart';

/// 学习中心页面
/// 
/// 为老年人提供各类学习内容，包括：
/// - 推荐课程
/// - 课程分类
/// - 学习进度
/// - 收藏课程
class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  // 课程分类列表
  final List<String> _categories = [
    '健康养生',
    '兴趣爱好',
    '科技使用',
    '生活技能',
    '文化艺术',
  ];

  // 推荐课程列表（示例数据）
  final List<Map<String, dynamic>> _recommendedCourses = [
    {
      'title': '每日健康操',
      'description': '适合老年人的简单健身操',
      'image': 'assets/images/course1.jpg',
      'duration': '15分钟',
      'id': '1',
    },
    {
      'title': '智能手机入门',
      'description': '手把手教您使用智能手机',
      'image': 'assets/images/course2.jpg',
      'duration': '30分钟',
      'id': '2',
    },
    {
      'title': '中医养生知识',
      'description': '传统中医养生方法详解',
      'image': 'assets/images/course3.jpg',
      'duration': '20分钟',
      'id': '3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '学习中心',
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
              // TODO: 实现搜索功能
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
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: AppTheme.iconSizeMedium,
                    color: AppTheme.secondaryColor,
                  ),
                  SizedBox(width: AppTheme.spacingMedium),
                  Expanded(
                    child: Text(
                      '今天想学习什么呢？',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 课程分类
            const Text(
              '课程分类',
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spacingMedium),
                    child: GestureDetector(
                      onTap: () {
                        // 导航到分类详情页
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QAListScreen(category: _categories[index]),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              _getCategoryIcon(index),
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _categories[index],
                            style: const TextStyle(
                              fontSize: AppTheme.fontSizeSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 推荐课程
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '推荐课程',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // 导航到课程列表页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QAListScreen(category: '全部'),
                      ),
                    );
                  },
                  child: const Text(
                    '查看全部',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeSmall,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recommendedCourses.length,
              itemBuilder: (context, index) {
                final course = _recommendedCourses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
                  child: _buildCourseCard(course),
                );
              },
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 继续学习
            const Text(
              '继续学习',
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/course1.jpg'),
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
                  const SizedBox(width: AppTheme.spacingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '每日健康操',
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '已完成 2/5 课时',
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeSmall,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.4,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 根据索引返回分类图标
  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.favorite;
      case 1:
        return Icons.palette;
      case 2:
        return Icons.smartphone;
      case 3:
        return Icons.home;
      case 4:
        return Icons.music_note;
      default:
        return Icons.book;
    }
  }

  // 构建课程卡片
  Widget _buildCourseCard(Map<String, dynamic> course) {
    return GestureDetector(
      onTap: () {
        // 导航到课程详情页
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(courseId: course['id']),
          ),
        );
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 课程图片
            Container(
              height: 150,
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
            ),
            // 课程信息
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['description'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeSmall,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course['duration'],
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeExtraSmall,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // 导航到课程详情页
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(courseId: course['id']),
                            ),
                          );
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
                          '开始学习',
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeSmall,
                            fontWeight: FontWeight.bold,
                          ),
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