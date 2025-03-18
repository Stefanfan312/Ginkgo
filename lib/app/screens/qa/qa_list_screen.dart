import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'qa_detail_screen.dart';

/// 问答列表页面
/// 
/// 展示问题列表，支持按分类筛选，包括：
/// - 问题分类选择
/// - 问题列表展示
/// - 问题搜索功能
/// - 排序功能
class QAListScreen extends StatefulWidget {
  final String? category;
  
  const QAListScreen({super.key, this.category});

  @override
  State<QAListScreen> createState() => _QAListScreenState();
}

class _QAListScreenState extends State<QAListScreen> {
  String _selectedCategory = '全部';
  String _sortBy = '最新';
  bool _isLoading = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  // 问题分类列表
  final List<String> _categories = [
    '全部',
    '手机基础',
    '应用使用',
    '网络设置',
    '安全防护',
    '其他问题',
  ];
  
  // 排序选项
  final List<String> _sortOptions = [
    '最新',
    '热门',
    '已解决',
    '未解决',
  ];
  
  // 模拟问题数据
  final List<Map<String, dynamic>> _questions = [
    {
      'id': '1',
      'title': '如何在手机上设置大字体？',
      'content': '我年纪大了，看手机字体太小，眼睛很吃力。请问如何把手机上的字体调大一些？我用的是华为手机。',
      'asker': '张大爷',
      'askerAvatar': 'assets/images/avatar1.jpg',
      'time': '2023-10-15',
      'viewCount': 56,
      'answerCount': 2,
      'category': '手机基础',
      'isResolved': true,
    },
    {
      'id': '2',
      'title': '微信如何添加好友？',
      'content': '刚开始使用微信，不知道如何添加好友，请问有什么简单的方法吗？',
      'asker': '李奶奶',
      'askerAvatar': 'assets/images/avatar2.jpg',
      'time': '2023-10-16',
      'viewCount': 78,
      'answerCount': 3,
      'category': '应用使用',
      'isResolved': true,
    },
    {
      'id': '3',
      'title': '如何连接WiFi网络？',
      'content': '家里安装了宽带，但不知道怎么用手机连接WiFi，请问具体步骤是什么？',
      'asker': '王爷爷',
      'askerAvatar': 'assets/images/avatar3.jpg',
      'time': '2023-10-17',
      'viewCount': 120,
      'answerCount': 5,
      'category': '网络设置',
      'isResolved': true,
    },
    {
      'id': '4',
      'title': '手机发热严重怎么解决？',
      'content': '我的手机最近使用一会儿就很烫，担心会不会有问题，该怎么解决？',
      'asker': '赵大妈',
      'askerAvatar': 'assets/images/avatar4.jpg',
      'time': '2023-10-18',
      'viewCount': 65,
      'answerCount': 2,
      'category': '手机基础',
      'isResolved': false,
    },
    {
      'id': '5',
      'title': '如何防范电信诈骗？',
      'content': '最近听说很多老年人被电信诈骗，请问有什么方法可以识别和防范电信诈骗？',
      'asker': '钱阿姨',
      'askerAvatar': 'assets/images/avatar5.jpg',
      'time': '2023-10-19',
      'viewCount': 200,
      'answerCount': 8,
      'category': '安全防护',
      'isResolved': true,
    },
  ];
  
  // 筛选后的问题列表
  List<Map<String, dynamic>> get _filteredQuestions {
    List<Map<String, dynamic>> result = List.from(_questions);
    
    // 按分类筛选
    if (_selectedCategory != '全部') {
      result = result.where((q) => q['category'] == _selectedCategory).toList();
    }
    
    // 按搜索关键词筛选
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((q) => 
        q['title'].toLowerCase().contains(query) || 
        q['content'].toLowerCase().contains(query)
      ).toList();
    }
    
    // 按选项排序
    switch (_sortBy) {
      case '最新':
        result.sort((a, b) => b['time'].compareTo(a['time']));
        break;
      case '热门':
        result.sort((a, b) => b['viewCount'].compareTo(a['viewCount']));
        break;
      case '已解决':
        result = result.where((q) => q['isResolved']).toList();
        result.sort((a, b) => b['time'].compareTo(a['time']));
        break;
      case '未解决':
        result = result.where((q) => !q['isResolved']).toList();
        result.sort((a, b) => b['time'].compareTo(a['time']));
        break;
    }
    
    return result;
  }
  
  @override
  void initState() {
    super.initState();
    
    // 如果有传入分类，则设置为当前选中分类
    if (widget.category != null && _categories.contains(widget.category)) {
      _selectedCategory = widget.category!;
    }
    
    // 模拟加载数据
    _loadQuestions();
  }
  
  @override
  void dispose() {
    // 释放资源
    _searchController.dispose();
    super.dispose();
  }
  
  // 加载问题数据
  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
    });
    
    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      _isLoading = false;
    });
  }
  
  // 刷新问题列表
  Future<void> _refreshQuestions() async {
    await _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '问答列表',
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
              // 显示搜索对话框
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('搜索问题'),
                  content: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: '输入关键词搜索问题',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _searchQuery = value.trim();
                      });
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _searchQuery = _searchController.text.trim();
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('搜索'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 分类和排序选项
          _buildFilterOptions(),
          
          // 搜索状态显示
          if (_searchQuery.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
                vertical: AppTheme.spacingSmall,
              ),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  const Icon(Icons.search, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '搜索结果: "$_searchQuery"',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeSmall,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    child: const Icon(Icons.close, size: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          
          // 问题列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredQuestions.isEmpty
                    ? _buildEmptyView()
                    : RefreshIndicator(
                        onRefresh: _refreshQuestions,
                        color: AppTheme.primaryColor,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(AppTheme.spacingMedium),
                          itemCount: _filteredQuestions.length,
                          itemBuilder: (context, index) {
                            final question = _filteredQuestions[index];
                            return _buildQuestionCard(question);
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 导航到提问页面
          Navigator.pushNamed(context, '/qa/ask');
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add_comment, color: Colors.black),
      ),
    );
  }
  
  // 构建筛选选项
  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // 分类选择
          SizedBox(
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
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: AppTheme.spacingMedium),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMedium,
                      vertical: AppTheme.spacingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
          ),
          
          const SizedBox(height: AppTheme.spacingMedium),
          
          // 排序选项
          Row(
            children: [
              const Text(
                '排序: ',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              DropdownButton<String>(
                value: _sortBy,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, size: 20),
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textPrimaryColor,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _sortBy = newValue;
                    });
                  }
                },
                items: _sortOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // 构建问题卡片
  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: InkWell(
        onTap: () {
          // 导航到问题详情页
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QADetailScreen(questionId: question['id']),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 问题标题
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      question['title'],
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (question['isResolved'])
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '已解决',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingSmall),
              
              // 问题内容预览
              Text(
                question['content'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingMedium),
              
              // 问题信息栏
              Row(
                children: [
                  // 提问者头像
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(question['askerAvatar']),
                  ),
                  const SizedBox(width: 8),
                  
                  // 提问者名称
                  Text(
                    question['asker'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // 分类标签
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      question['category'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingSmall),
              
              // 回答数和浏览量
              Row(
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${question['answerCount']} 回答',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
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
                    '${question['viewCount']} 浏览',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    question['time'],
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // 构建空列表视图
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.question_answer,
            size: AppTheme.iconSizeLarge,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Text(
            '暂无相关问题',
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          Text(
            '可以尝试更换分类或提出新问题',
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/qa/ask');
            },
            icon: const Icon(Icons.add),
            label: const Text('我要提问'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLarge,
                vertical: AppTheme.spacingMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}