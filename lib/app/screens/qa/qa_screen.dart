import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'ask_question_screen.dart';
import 'qa_detail_screen.dart';
import 'qa_list_screen.dart';

/// 提问中心页面
/// 
/// 为老年人提供智能手机使用问题的提问和解答功能，包括：
/// - 提出问题
/// - 查看历史问题
/// - 浏览热门问题
/// - 查看问题回答
class QAScreen extends StatefulWidget {
  const QAScreen({super.key});

  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  // 问题分类列表
  final List<String> _categories = [
    '全部',
    '手机基础',
    '应用使用',
    '网络设置',
    '安全防护',
  ];

  // 当前选中的分类
  String _selectedCategory = '全部';

  // 热门问题列表（示例数据）
  final List<Map<String, dynamic>> _hotQuestions = [
    {
      'title': '如何连接WiFi网络？',
      'answers': 5,
      'views': 120,
    },
    {
      'title': '微信如何添加好友？',
      'answers': 8,
      'views': 200,
    },
    {
      'title': '手机相册照片如何删除？',
      'answers': 3,
      'views': 98,
    },
    {
      'title': '如何设置手机铃声？',
      'answers': 4,
      'views': 85,
    },
  ];

  // 我的问题列表（示例数据）
  final List<Map<String, dynamic>> _myQuestions = [
    {
      'title': '如何更改手机字体大小？',
      'time': '2023-10-15',
      'status': '已回答',
    },
    {
      'title': '手机发热严重怎么解决？',
      'time': '2023-10-10',
      'status': '已回答',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '提问中心',
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
            // 提问按钮
            _buildAskButton(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 问题分类
            _buildCategorySelector(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 热门问题
            _buildSectionTitle('热门问题'),
            _buildHotQuestions(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // 我的问题
            _buildSectionTitle('我的问题'),
            _buildMyQuestions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 导航到提问页面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AskQuestionScreen(),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add_comment, color: Colors.black),
      ),
    );
  }
  
  // 构建提问按钮
  Widget _buildAskButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '有使用手机的问题吗？',
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '在这里提问，获得专业解答',
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // 导航到提问页面
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AskQuestionScreen(),
                ),
              );
            },
            icon: const Icon(Icons.help_outline),
            label: const Text('我要提问'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // 构建问题分类选择器
  Widget _buildCategorySelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
              
              // 导航到问答列表页面，并传递选中的分类
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QAListScreen(category: category),
                ),
              );
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
  
  // 构建热门问题列表
  Widget _buildHotQuestions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _hotQuestions.length,
      itemBuilder: (context, index) {
        final question = _hotQuestions[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              question['title'],
              style: const TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${question['answers']}个回答',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${question['views']}次浏览',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // 导航到问题详情页面
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QADetailScreen(questionId: '${index + 1}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
  
  // 构建我的问题列表
  Widget _buildMyQuestions() {
    return _myQuestions.isEmpty
        ? _buildEmptyState('您还没有提问过问题')
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _myQuestions.length,
            itemBuilder: (context, index) {
              final question = _myQuestions[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    question['title'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          question['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            question['status'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // 导航到问题详情页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QADetailScreen(questionId: '${index + 1}'),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
  
  // 构建空状态提示
  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.help_outline,
            size: AppTheme.iconSizeLarge,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Text(
            message,
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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