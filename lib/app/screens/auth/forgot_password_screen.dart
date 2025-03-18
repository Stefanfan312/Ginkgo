import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../services/auth_service.dart';

/// 忘记密码页面
/// 
/// 为老年用户提供简洁易用的找回密码界面，包括：
/// - 手机号输入
/// - 验证码获取
/// - 新密码设置
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isSendingCode = false;
  int _countDown = 0;
  final AuthService _authService = AuthService();
  
  // 当前步骤
  int _currentStep = 0;
  
  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // 发送验证码
  Future<void> _sendVerificationCode() async {
    if (_phoneController.text.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入正确的手机号')),
      );
      return;
    }
    
    setState(() {
      _isSendingCode = true;
    });
    
    try {
      // 调用认证服务发送验证码
      await _authService.sendVerificationCode(_phoneController.text);
      
      // 发送成功后开始倒计时
      setState(() {
        _countDown = 60;
      });
      
      // 倒计时
      Future.doWhile(() async {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            if (_countDown > 0) {
              _countDown--;
            }
          });
        }
        return _countDown > 0 && mounted;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('验证码已发送')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发送失败：$e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }
  
  // 验证手机号和验证码
  Future<void> _verifyPhoneAndCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // TODO: 实现验证手机号和验证码的API调用
        await Future.delayed(const Duration(seconds: 1));
        
        // 模拟验证成功，进入下一步
        setState(() {
          _currentStep = 1;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('验证失败：$e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  // 重置密码
  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // TODO: 实现重置密码的API调用
        await Future.delayed(const Duration(seconds: 1));
        
        // 模拟重置成功
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('密码重置成功！')),
        );
        
        // 重置成功后导航到登录页面
        if (mounted) {
          context.go('/login');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('重置失败：$e')),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.textPrimaryColor,
            size: AppTheme.iconSizeMedium,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '找回密码',
          style: TextStyle(
            fontSize: AppTheme.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 步骤指示器
                _buildStepIndicator(),
                const SizedBox(height: AppTheme.spacingLarge * 2),
                
                // 根据当前步骤显示不同的表单
                _currentStep == 0 ? _buildVerificationForm() : _buildPasswordResetForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // 构建步骤指示器
  Widget _buildStepIndicator() {
    return Row(
      children: [
        _buildStepCircle(0, '验证身份'),
        Expanded(
          child: Container(
            height: 2,
            color: _currentStep >= 1 ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
        ),
        _buildStepCircle(1, '重置密码'),
      ],
    );
  }
  
  // 构建步骤圆圈
  Widget _buildStepCircle(int step, String label) {
    final isActive = _currentStep >= step;
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              '${step + 1}',
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            color: isActive ? AppTheme.textPrimaryColor : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
  
  // 构建验证表单
  Widget _buildVerificationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '请输入您的手机号和验证码',
          style: TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        
        // 手机号输入框
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
          decoration: InputDecoration(
            labelText: '手机号',
            hintText: '请输入您的手机号',
            labelStyle: const TextStyle(fontSize: AppTheme.fontSizeSmall),
            hintStyle: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
            contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
            prefixIcon: const Icon(
              Icons.phone_android,
              color: AppTheme.textSecondaryColor,
              size: AppTheme.iconSizeSmall,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '请输入手机号';
            } else if (value.length != 11) {
              return '请输入11位手机号';
            }
            return null;
          },
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        
        // 验证码输入框
        TextFormField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
          decoration: InputDecoration(
            labelText: '验证码',
            hintText: '请输入验证码',
            labelStyle: const TextStyle(fontSize: AppTheme.fontSizeSmall),
            hintStyle: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
            contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
            prefixIcon: const Icon(
              Icons.message,
              color: AppTheme.textSecondaryColor,
              size: AppTheme.iconSizeSmall,
            ),
            suffixIcon: TextButton(
              onPressed: _countDown > 0 || _isSendingCode ? null : _sendVerificationCode,
              child: _isSendingCode
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    )
                  : Text(
                      _countDown > 0 ? '${_countDown}秒后重发' : '获取验证码',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeSmall,
                        color: _countDown > 0 ? Colors.grey : AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '请输入验证码';
            } else if (value.length != 6) {
              return '请输入6位验证码';
            }
            return null;
          },
        ),
        const SizedBox(height: AppTheme.spacingLarge * 2),
        
        // 下一步按钮
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
              elevation: 2,
            ),
            onPressed: _isLoading ? null : _verifyPhoneAndCode,
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    '下一步',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
  
  // 构建密码重置表单
  Widget _buildPasswordResetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '请设置新密码',
          style: TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        
        // 密码输入框
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
          decoration: InputDecoration(
            labelText: '新密码',
            hintText: '请设置新密码',
            labelStyle: const TextStyle(fontSize: AppTheme.fontSizeSmall),
            hintStyle: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
            contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppTheme.textSecondaryColor,
              size: AppTheme.iconSizeSmall,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.textSecondaryColor,
                size: AppTheme.iconSizeSmall,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '请输入新密码';
            } else if (value.length < 6) {
              return '密码长度不能少于6位';
            }
            return null;
          },
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        
        // 确认密码输入框
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
          decoration: InputDecoration(
            labelText: '确认密码',
            hintText: '请再次输入新密码',
            labelStyle: const TextStyle(fontSize: AppTheme.fontSizeSmall),
            hintStyle: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
            contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppTheme.textSecondaryColor,
              size: AppTheme.iconSizeSmall,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.textSecondaryColor,
                size: AppTheme.iconSizeSmall,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '请再次输入新密码';
            } else if (value != _passwordController.text) {
              return '两次输入的密码不一致';
            }
            return null;
          },
        ),
        const SizedBox(height: AppTheme.spacingLarge * 2),
        
        // 完成按钮
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
              elevation: 2,
            ),
            onPressed: _isLoading ? null : _resetPassword,
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    '完成',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}