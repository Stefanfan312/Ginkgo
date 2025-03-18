import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'lesson_video_screen.dart';

/// 课程详情页面
/// 
/// 为老年用户提供课程详细信息和学习功能，包括：
/// - 课程封面和基本信息
/// - 课程简介
/// - 课程章节列表
/// - 开始学习按钮
/// - 收藏和分享功能
class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  
  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isFavorite = false;
  
  // 模拟课程数据
  late Map<String, dynamic> _courseData;
  
  @override
  void initState() {
    super.initState();
    // 根据课程ID获取课程数据
    _loadCourseData();
  }
  
  void _loadCourseData() {
    // TODO: 从API获取课程数据
    // 模拟数据
    _courseData = {
      'id': widget.courseId,
      'title': '智能手机基础操作',
      'coverImage': 'assets/images/course_cover.jpg',
      'instructor': '王老师',
      'duration': '2小时30分钟',
      'rating': 4.8,
      'ratingCount': 126,
      'description': '本课程专为老年人设计，通过简单易懂的讲解和演示，帮助您掌握智能手机的基本操作。从开机、解锁到使用常用应用，全面覆盖日常使用场景。',
      'chapters': [
        {
          'title': '第1章：认识您的智能手机',
          'duration': '30分钟',
          'lessons': [
            {'title': '1.1 手机按键和基本功能', 'duration': '10分钟', 'videoUrl': 'assets/videos/lesson1.mp4'},
            {'title': '1.2 开机和解锁', 'duration': '8分钟', 'videoUrl': 'assets/videos/lesson2.mp4'},
            {'title': '1.3 触摸屏操作基础', 'duration': '12分钟', 'videoUrl': 'assets/videos/lesson3.mp4'},
          ],
        },
        {
          'title': '第2章：基本设置和个性化',
          'duration': '35分钟',
          'lessons': [
            {'title': '2.1 调整字体大小', 'duration': '8分钟', 'videoUrl': 'assets/videos/lesson4.mp4'},
            {'title': '2.2 设置壁纸和主题', 'duration': '10分钟', 'videoUrl': 'assets/videos/lesson5.mp4'},
            {'title': '2.3 调整音量和亮度', 'duration': '7分钟', 'videoUrl': 'assets/videos/lesson6.mp4'},
            {'title': '2.4 设置紧急联系人', 'duration': '10分钟', 'videoUrl': 'assets/videos/lesson7.mp4'},
          ],
        },
        {
          'title': '第3章：常用应用使用指南',
          'duration': '45分钟',
          'lessons': [
            {'title': '3.1 拨打和接听电话', 'duration': '12分钟', 'videoUrl': 'assets/videos/lesson8.mp4'},
            {'title': '3.2 发送短信和使用微信', 'duration': '15分钟', 'videoUrl': 'assets/videos/lesson9.mp4'},
            {'title': '3.3 使用相机拍照和查看照片', 'duration': '18分钟', 'videoUrl': 'assets/videos/lesson10.mp4'},
          ],
        },
      ],
    };
  }
  
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    // TODO: 实现收藏/取消收藏逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? '已添加到收藏' : '已取消收藏'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
  
  void _shareCourse() {
    // TODO: 实现分享功能
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('分享功能开发中...'),
        duration: Duration(seconds: 1),
      ),
    );
  }
  
  void _startLearning() {
    // 导航到第一课
    final firstChapter = _courseData['chapters'][0];
    final firstLesson = firstChapter['lessons'][0];
    
    // 导航到视频播放页面
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonVideoScreen(
          videoUrl: firstLesson['videoUrl'],
          lessonTitle: firstLesson['title'],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 顶部应用栏和课程封面
          _buildAppBar(),
          
          // 课程内容
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 课程标题和基本信息
                  _buildCourseHeader(),
                  const SizedBox(height: AppTheme.spacingLarge),
                  
                  // 课程简介
                  _buildCourseDescription(),
                  const SizedBox(height: AppTheme.spacingLarge),
                  
                  // 课程章节
                  _buildChaptersList(),
                ],
              ),
            ),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar: _buildBottomBar(),
    );
  }
  
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 课程封面图
            Image.asset(
              'assets/images/course_cover.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
            // 渐变遮罩，确保标题可见
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        // 收藏按钮
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
          ),
          onPressed: _toggleFavorite,
        ),
        // 分享按钮
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: _shareCourse,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
  
  Widget _buildCourseHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 课程标题
        Text(
          _courseData['title'],
          style: const TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        
        // 讲师信息
        Row(
          children: [
            const Icon(
              Icons.person,
              size: 20,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 4),
            Text(
              '讲师: ${_courseData['instructor']}',
              style: const TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        
        // 课程时长
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 20,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 4),
            Text(
              '总时长: ${_courseData['duration']}',
              style: const TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        
        // 评分
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 20,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              '${_courseData['rating']} (${_courseData['ratingCount']}人评价)',
              style: const TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildCourseDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '课程简介',
          style: TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        Text(
          _courseData['description'],
          style: const TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            color: AppTheme.textSecondaryColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
  
  Widget _buildChaptersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '课程章节',
          style: TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingMedium),
        
        // 章节列表
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _courseData['chapters'].length,
          itemBuilder: (context, chapterIndex) {
            final chapter = _courseData['chapters'][chapterIndex];
            return _buildChapterItem(chapter, chapterIndex);
          },
        ),
      ],
    );
  }
  
  Widget _buildChapterItem(Map<String, dynamic> chapter, int chapterIndex) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: ExpansionTile(
        initiallyExpanded: chapterIndex == 0, // 默认展开第一章
        title: Text(
          chapter['title'],
          style: const TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          '时长: ${chapter['duration']}',
          style: const TextStyle(
            fontSize: AppTheme.fontSizeExtraSmall,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chapter['lessons'].length,
            itemBuilder: (context, lessonIndex) {
              final lesson = chapter['lessons'][lessonIndex];
              return _buildLessonItem(lesson, chapterIndex, lessonIndex);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildLessonItem(Map<String, dynamic> lesson, int chapterIndex, int lessonIndex) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.play_circle_outline,
            color: AppTheme.primaryColor,
            size: 24,
          ),
        ),
      ),
      title: Text(
        lesson['title'],
        style: const TextStyle(
          fontSize: AppTheme.fontSizeSmall,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
      ),
      subtitle: Text(
        '时长: ${lesson['duration']}',
        style: const TextStyle(
          fontSize: AppTheme.fontSizeExtraSmall,
          color: AppTheme.textSecondaryColor,
        ),
      ),
      onTap: () {
        // 导航到视频播放页面
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonVideoScreen(
              videoUrl: lesson['videoUrl'],
              lessonTitle: lesson['title'],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
            elevation: 0,
          ),
          onPressed: _startLearning,
          child: const Text(
            '开始学习',
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}