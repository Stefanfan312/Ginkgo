import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// 问答详情页面
/// 
/// 展示问题详情和回答列表，包括：
/// - 问题标题和内容
/// - 提问者信息
/// - 回答列表
/// - 回答提交功能
class QADetailScreen extends StatefulWidget {
  final String questionId;
  
  const QADetailScreen({super.key, required this.questionId});

  @override
  State<QADetailScreen> createState() => _QADetailScreenState();
}

class _QADetailScreenState extends State<QADetailScreen> {
  final TextEditingController _answerController = TextEditingController();
  bool _isLoading = false;
  
  // 模拟问题数据
  late Map<String, dynamic> _questionData;
  
  @override
  void initState() {
    super.initState();
    _loadQuestionData();
  }
  
  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
  
  // 加载问题数据
  void _loadQuestionData() {
    // TODO: 从API获取问题数据
    // 模拟数据
    _questionData = {
      'id': widget.questionId,
      'title': '如何在手机上设置大字体？',
      'content': '我年纪大了，看手机字体太小，眼睛很吃力。请问如何把手机上的字体调大一些？我用的是华为手机。',
      'asker': '张大爷',
      'askerAvatar': 'assets/images/avatar1.jpg',
      'time': '2023-10-15',
      'viewCount': 56,
      'answers': [
        {
          'id': '1',
          'content': '华为手机设置大字体的方法：\n1. 打开手机的"设置"应用\n2. 滚动找到并点击"显示"选项\n3. 点击"文字大小"\n4. 拖动滑块调整字体大小，右侧更大\n5. 调整满意后点击"确定"',
          'answerer': '李老师',
          'answererAvatar': 'assets/images/avatar2.jpg',
          'time': '2023-10-16',
          'likes': 12,
          'isAccepted': true,
        },
        {
          'id': '2',
          'content': '补充一点，华为手机还可以在设置中找到"辅助功能"，里面有"视觉"选项，可以设置更多字体相关的功能，比如粗体字等。',
          'answerer': '王医生',
          'answererAvatar': 'assets/images/avatar3.jpg',
          'time': '2023-10-17',
          'likes': 5,
          'isAccepted': false,
        },
      ],
    };
  }
  
  // 提交回答
  Future<void> _submitAnswer() async {
    // 验证输入
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入回答内容')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // TODO: 实现真实的API调用
      // 模拟API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 添加新回答
      setState(() {
        _questionData['answers'].add({
          'id': '${_questionData['answers'].length + 1}',
          'content': _answerController.text,
          'answerer': '我',
          'answererAvatar': 'assets/images/avatar_default.jpg',
          'time': '刚刚',
          'likes': 0,
          'isAccepted': false,
        });
        
        // 清空输入框
        _answerController.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('回答已提交')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交失败：$e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // 点赞回答
  void _likeAnswer(String answerId) {
    // 查找回答并更新点赞数
    for (int i = 0; i < _questionData['answers'].length; i++) {
      if (_questionData['answers'][i]['id'] == answerId) {
        setState(() {
          _questionData['answers'][i]['likes']++;
        });
        break;
      }
    }
    
    // TODO: 实现点赞的API调用
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('点赞成功'),
        duration: Duration(seconds: 1),
      ),
    );
  }
  
  // 采纳回答
  void _acceptAnswer(String answerId) {
    // 先将所有回答设为未采纳
    for (int i = 0; i < _questionData['answers'].length; i++) {
      setState(() {
        _questionData['answers'][i]['isAccepted'] = false;
      });
    }
    
    // 设置选中的回答为已采纳
    for (int i = 0; i < _questionData['answers'].length; i++) {
      if (_questionData['answers'][i]['id'] == answerId) {
        setState(() {
          _questionData['answers'][i]['isAccepted'] = true;
        });
        break;
      }
    }
    
    // TODO: 实现采纳的API调用
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已采纳此回答'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '问题详情',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: AppTheme.iconSizeMedium),
            onPressed: () {
              // TODO: 实现分享功能
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('分享功能开发中...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 问题详情
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 问题标题
                  Text(
                    _questionData['title'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // 提问者信息和时间
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(_questionData['askerAvatar']),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _questionData['asker'],
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _questionData['time'],
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeExtraSmall,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // 问题内容
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    ),
                    child: Text(
                      _questionData['content'],
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // 浏览次数
                  Text(
                    '${_questionData['viewCount']} 次浏览',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  
                  const Divider(height: 32),
                  
                  // 回答标题
                  Row(
                    children: [
                      const Text(
                        '回答',
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_questionData['answers'].length}',
                          style: const TextStyle(
                            fontSize: AppTheme.fontSizeExtraSmall,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // 回答列表
                  ..._buildAnswersList(),
                ],
              ),
            ),
          ),
          
          // 回答输入框
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _answerController,
                    decoration: InputDecoration(
                      hintText: '写下您的回答...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                        vertical: AppTheme.spacingSmall,
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSmall),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMedium,
                      vertical: AppTheme.spacingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('提交'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // 构建回答列表
  List<Widget> _buildAnswersList() {
    final List<Widget> answerWidgets = [];
    
    for (int i = 0; i < _questionData['answers'].length; i++) {
      final answer = _questionData['answers'][i];
      
      answerWidgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            color: answer['isAccepted'] ? Colors.green.shade50 : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 回答者信息和时间
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(answer['answererAvatar']),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    answer['answerer'],
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (answer['isAccepted'])
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 12, color: Colors.white),
                          SizedBox(width: 2),
                          Text(
                            '已采纳',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Text(
                    answer['time'],
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeExtraSmall,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              
              // 回答内容
              Text(
                answer['content'],
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                ),
              ),
              const SizedBox(height: AppTheme.spacingMedium),
              
              // 操作按钮（点赞和采纳）
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 采纳按钮 - 只有未采纳的回答才显示
                  if (!answer['isAccepted'])
                    GestureDetector(
                      onTap: () => _acceptAnswer(answer['id']),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: Colors.green.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '采纳',
                              style: TextStyle(
                                fontSize: AppTheme.fontSizeExtraSmall,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(width: 12),
                  
                  // 点赞按钮
                  GestureDetector(
                    onTap: () => _likeAnswer(answer['id']),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 16,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${answer['likes']}',
                            style: TextStyle(
                              fontSize: AppTheme.fontSizeExtraSmall,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    
    return answerWidgets;
  }
}