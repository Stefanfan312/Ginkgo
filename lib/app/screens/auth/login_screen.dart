import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../services/auth_service.dart';

/// 登录页面
/// 
/// 为老年用户提供简洁易用的登录界面，包括：
/// - 手机号/账号输入
/// - 密码输入
/// - 记住账号选项
/// - 忘记密码链接
/// - 第三方登录选项
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // 调用认证服务进行登录
        await _authService.loginWithPassword(
          _phoneController.text,
          _passwordController.text,
        );
        
        // 保存账号
        if (_rememberMe) {
          // TODO: 保存账号到本地存储
        }
        
        // 登录成功后导航到首页
        if (mounted) {
          context.go('/');
        }
        if (mounted) {
          context.go('/');
        }
      } catch (e) {
        // 登录失败，显示错误信息
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('登录失败：$e')),
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
  
  // 短信登录
  Future<void> _loginWithSms() async {
    // 导航到短信登录页面
    // TODO: 实现短信登录页面
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('短信登录功能开发中...')),
    );
  }
  
  // 微信登录
  Future<void> _loginWithWeChat() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // 调用认证服务进行微信登录
      await _authService.loginWithWeChat();
      
      // 登录成功后导航到首页
      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      // 登录失败，显示错误信息
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('微信登录失败：$e')),
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
                  '欢迎回来',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeExtraLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMedium),
                const Text(
                  '请登录您的账号',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLarge * 2),

                // 手机号输入框
                _buildPhoneInput(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 密码输入框
                _buildPasswordInput(),
                const SizedBox(height: AppTheme.spacingMedium),

                // 记住账号和忘记密码
                _buildRememberAndForgot(),
                const SizedBox(height: AppTheme.spacingLarge * 2),

                // 登录按钮
                _buildLoginButton(),
                const SizedBox(height: AppTheme.spacingLarge),

                // 注册提示
                _buildRegisterHint(),
                const SizedBox(height: AppTheme.spacingLarge * 2),

                // 第三方登录
                _buildThirdPartyLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '请输入您的密码',
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

  Widget _buildRememberAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 记住账号
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _rememberMe,
                activeColor: AppTheme.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? true;
                  });
                },
              ),
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            const Text(
              '记住账号',
              style: TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        
        // 忘记密码
        TextButton(
          onPressed: () {
            // 导航到忘记密码页面
            context.push('/forgot-password');
          },
          child: const Text(
            '忘记密码？',
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          elevation: 2,
        ),
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                '登录',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildRegisterHint() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '还没有账号？',
          style: TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: 导航到注册页面
            context.push('/register');
          },
          child: const Text(
            '立即注册',
            style: TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThirdPartyLogin() {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
              child: Text(
                '其他登录方式',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildThirdPartyButton(
              icon: Icons.wechat,
              label: '微信',
              color: const Color(0xFF07C160),
              onTap: _loginWithWeChat,
            ),
            _buildThirdPartyButton(
              icon: Icons.phone_android,
              label: '短信',
              color: const Color(0xFF1976D2),
              onTap: _loginWithSms,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThirdPartyButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: AppTheme.iconSizeLarge,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppTheme.fontSizeSmall,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}