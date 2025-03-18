import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 导入页面组件
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/home/main_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/learn/course_detail_screen.dart';
import '../screens/learn/video_player_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/user_activities_screen.dart';
import '../screens/qa/qa_screen.dart';
import '../screens/social/activity_detail_screen.dart';
import '../screens/social/activity_list_screen.dart';

/// 应用路由配置
/// 
/// 使用go_router管理应用的导航路由
/// 包含主要功能模块的路由定义：
/// - 首页
/// - 学习中心
/// - 个人中心
/// - 认证页面
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    // 主页路由 - 包含底部导航栏的主界面
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
      routes: [
        // 学习中心路由
        GoRoute(
          path: 'learn',
          builder: (context, state) => const HomeScreen(
            initialTabIndex: 1,
            child: Center(child: Text('学习中心')),
          ),
          routes: [
            // 课程详情页
            GoRoute(
              path: 'course/:courseId',
              builder: (context, state) {
                final courseId = state.pathParameters['courseId']!;
                return CourseDetailScreen(courseId: courseId);
              },
              routes: [
                // 视频播放页
                GoRoute(
                  path: 'video',
                  builder: (context, state) {
                    final videoUrl = state.uri.queryParameters['url'] ?? '';
                    final lessonTitle = state.uri.queryParameters['title'] ?? '视频课程';
                    return VideoPlayerScreen(
                      videoUrl: videoUrl,
                      lessonTitle: lessonTitle,
                    );
                  },
                ),
              ],
            ),
            // 独立视频播放页
            GoRoute(
              path: 'video/:videoId',
              builder: (context, state) {
                final videoId = state.pathParameters['videoId']!;
                final videoUrl = 'assets/videos/$videoId.mp4';
                return VideoPlayerScreen(
                  videoUrl: videoUrl,
                  lessonTitle: '视频课程',
                );
              },
            ),
          ],
        ),
        
        // 问答中心路由
        GoRoute(
          path: 'qa',
          builder: (context, state) => const HomeScreen(
            initialTabIndex: 2,
            child: QAScreen(),
          ),
        ),
        
        // 个人中心路由
        GoRoute(
          path: 'profile',
          builder: (context, state) => const HomeScreen(
            initialTabIndex: 3,
            child: ProfileScreen(),
          ),
          routes: [
            // 设置页面
            GoRoute(
              path: 'settings',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('设置 - 待实现', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            // 积分页面
            GoRoute(
              path: 'points',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('积分中心 - 待实现', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            // 用户活动页面
            GoRoute(
              path: 'activities',
              builder: (context, state) => const UserActivitiesScreen(
                userId: 'current_user_id', // TODO: 使用真实用户ID
              ),
            ),
            // 设置页面
            GoRoute(
              path: 'social',
              builder: (context, state) => const ActivityListScreen(),
              routes: [
                // 活动详情页面
                GoRoute(
                  path: ':activityId',
                  builder: (context, state) {
                    final activityId = state.pathParameters['activityId']!;
                    return ActivityDetailScreen(activityId: activityId);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    
    // 登录页面
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // 注册页面
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    
    // 忘记密码页面
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
  
  // 错误页面处理
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        '页面未找到: ${state.error}',
        style: const TextStyle(fontSize: 24),
      ),
    ),
  ),
);