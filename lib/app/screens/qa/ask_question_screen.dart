import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// 提问页面
/// 
/// 为老年用户提供简洁易用的提问界面，包括：
/// - 问题标题输入
/// - 问题详情输入
/// - 问题分类选择
/// - 提交按钮
class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = '手机基础';
  bool _isSubmitting = false;
  
  // 问题分类列表
  final List<String> _categories = [
    '手机基础',
    '应用使用',
    '网络设置',
    '安全防护',
    '其他问题',
  ];
  
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  
  // 提交问题
  Future<void> _submitQuestion() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      
      try {
        // TODO: 实现提交问题到API的逻辑
        // 模拟网络延迟
        await Future.delayed(const Duration(seconds: 1));
        
        if (mounted) {
          // 提交成功后返回上一页
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('问题提交成功！')),
          );
          
          // 延迟返回，让用户看到成功提示
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop(true); // 返回true表示提交成功
            }
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('提交失败：$e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '提出问题',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 提示信息
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: AppTheme.spacingMedium),
                    const Expanded(
                      child: Text(
                        '请详细描述您的问题，这样可以更快得到准确的回答',
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 问题标题
              const Text(
                '问题标题',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: '请用一句话描述您的问题',
                  hintStyle: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入问题标题';
                  } else if (value.length < 5) {
                    return '标题太短，请详细描述';
                  } else if (value.length > 50) {
                    return '标题太长，请简洁描述';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 问题分类
              const Text(
                '问题分类',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      color: AppTheme.textPrimaryColor,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      }
                    },
                    items: _categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingLarge),
              
              // 问题详情
              const Text(
                '问题详情',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              TextFormField(
                controller: _contentController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: '请详细描述您遇到的问题，例如：使用场景、尝试过的方法等',
                  hintStyle: TextStyle(
                    fontSize: AppTheme.fontSizeSmall,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入问题详情';
                  } else if (value.length < 10) {
                    return '内容太少，请详细描述您的问题';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.spacingLarge * 2),
              
              // 提交按钮
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : const Text(
                          '提交问题',
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}