import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../services/auth_service.dart';

/// 注册页面
/// 
/// 为老年用户提供简洁易用的注册界面，包括：
/// - 手机号输入
/// - 验证码获取
/// - 密码设置
/// - 用户协议确认
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  bool _isSendingCode = false;
  int _countDown = 0;
  final AuthService _authService = AuthService();
  
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
  
  // 注册
  Future<void> _register() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请阅读并同意用户协议')),
      );
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // 调用认证服务进行注册
        final name = '用户${_phoneController.text.substring(7)}'; // 简单生成用户名
        await _authService.register(
          name,
          _phoneController.text,
          _passwordController.text,
          _codeController.text,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('注册成功！')),
          );
          
          // 注册成功后导航到登录页面
          context.go('/login');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('注册失败：$e')),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                const Text(
                  '创建账号',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeExtraLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMedium),
                const Text(
                  '请填写以下信息完成注册',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLarge * 2),

                // 手机号输入框
                _buildPhoneInput(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 验证码输入框
                _buildVerificationCodeInput(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 密码输入框
                _buildPasswordInput(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 确认密码输入框
                _buildConfirmPasswordInput(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 用户协议
                _buildTermsAgreement(),
                const SizedBox(height: AppTheme.spacingLarge * 2),

                // 注册按钮
                _buildRegisterButton(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 登录提示
                _buildLoginHint(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // 构建手机号输入框
  Widget _buildPhoneInput() {
    return TextFormField(
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
    );
  }
  
  // 构建验证码输入框
  Widget _buildVerificationCodeInput() {
    return TextFormField(
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
    );
  }
  
  // 构建密码输入框
  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '请设置密码',
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
          return '请输入密码';
        } else if (value.length < 6) {
          return '密码长度不能少于6位';
        }
        return null;
      },
    );
  }
  
  // 构建确认密码输入框
  Widget _buildConfirmPasswordInput() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
      decoration: InputDecoration(
        labelText: '确认密码',
        hintText: '请再次输入密码',
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
          return '请再次输入密码';
        } else if (value != _passwordController.text) {
          return '两次输入的密码不一致';
        }
        return null;
      },
    );
  }
  
  // 构建用户协议
  Widget _buildTermsAgreement() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          activeColor: AppTheme.primaryColor,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
            },
            child: RichText(
              text: const TextSpan(
                text: '我已阅读并同意',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textSecondaryColor,
                ),
                children: [
                  TextSpan(
                    text: '《用户协议》',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: '和'),
                  TextSpan(
                    text: '《隐私政策》',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // 构建注册按钮
  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                '注册',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
  
  // 构建登录提示
  Widget _buildLoginHint() {
    return Center(
      child: GestureDetector(
        onTap: () => context.go('/login'),
        child: RichText(
          text: const TextSpan(
            text: '已有账号？',
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.textSecondaryColor,
            ),
            children: [
              TextSpan(
                text: '立即登录',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}